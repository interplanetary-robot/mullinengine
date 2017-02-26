
doc"""
  fracsign_crossmultiplier(SingleWire, Wire)
"""
@verilog function mul_frac_hidden_crossmultiplier(crosssign::SingleWire, frac::Wire, bits::Integer)
  @suffix "$(bits)bit"
  @input frac          range(bits - 3)

  #create a wire that represents the inverse of the fraction.  Why?  Because a
  #negative value has a hidden value of -2, which means left shift, then append
  #a top value for negation.
  inv_frac = -frac
  top_neg = (|)(inv_frac) & crosssign
  selected_inv_frac = inv_frac & ((bits - 2) * crosssign)
  selected_frac     = frac & ((bits - 2) * ~crosssign)
  result = Wire(top_neg, selected_inv_frac[bits - 2], (selected_inv_frac[(bits-1):0v] | selected_frac[(bit-2):1v]), selected_frac[0])
end

doc"""
  mul_frac_finisher()

  finishes up work on the fraction side.  Effectively, this looks at the reported
  'provisional fraction' result and reports whether or not it's necessary to
  do whatever.
"""
@verilog function mul_frac_finisher(final_sign::SingleWire, provisional_fraction::Wire, bits::Integer)
  @suffix "$(bits)bit"

  shift_selector = final_sign ^ provisional_fraction[msb]

  exponent_augment = Wire(2)
  exponent_augment[1] = ~^(provisional_fraction[(msb):(msb-1)v])  #take the top two for this value.
  exponent_augment[0] = shift_selector

  selected_one_shift_fraction = ((bits * 2 - 6) * shift_selector)  & provisional_fraction[(msb-1):1v]
  selected_two_shift_fraction = ((bits * 2 - 6) * ~shift_selector) & provisional_fraction[(msb-2):0v]
  selected_fraction = selected_one_shift_fraction | selected_two_shift_fraction

  result = Wire(exponent_augment, selected_fraction)
end

doc"""

  fraction_multiplier(SingleWire, Wire, SingleWire, Wire, bits_in)

  performs a fraction multiplication.  Outputs:

  | exponent_augment | MSB  ...fraction...  LSB |
  |       2 bits     |          f bits          |

  where f is length(lhs_frac) * length(rhs_frac)

"""
@verilog function mul_frac(lhs_sign::SingleWire, lhs_frac::Wire, rhs_sign::SingleWire, rhs_frac::Wire, bits::Integer)
  @suffix "$(bits)bit"
  @input lhs_frac        range(bits - 2)
  @input rhs_frac        range(bits - 2)

  lhs_frac_rhs_sign = mul_frac_hidden_crossmultiplier(lhs_frac, rhs_sign, bits)
  rhs_frac_lhs_sign = mul_frac_hidden_crossmultiplier(rhs_frac, lhs_sign, bits)

  top_hidden_bit = lhs_sign ^ rhs_sign
  next_hidden_bit = ~(lhs_sign | rhs_sign)

  #hidden_bit_lhs_sum represents the sum of the hidden bits and the lhs sum, added
  #sequentially.
  hidden_bit_lhs_sum = Wire(bits - 1)
  #the bottom bits of this value should just be copied directly over from the
  #result of the crossmultiplier, since those will be unaffected by the hidden
  #bits.
  hidden_bit_lhs_sum[(msb-2):0v] = lhs_frac_rhs_sign[(msb-2):0v]
  #the top two bits have to take the sum of the previous results.
  hidden_bit_lhs_sum[msb:(msb-1)v] = Wire(top_hidden_bit, next_hidden_bit) + lhs_frac_rhs_sign[msb:(msb-1)v]


  #full_hidden_bit_sum represents the result of summing all of the hidden bit
  #components.
  full_hidden_bit_sum = hidden_lhs_sum + rhs_frac_lhs_sign

  #fracmultiply is the basic result of the binary multiply.
  fracmultiply = lhs_frac * rhs_frac

  #this is a buffer for storing the temporary result (which may need to be shifted)
  frac_result = Wire(bits * 2 - 4)

  #the trailing bits of frac_result come exclusively from the direct binary multiply.
  frac_result[(bits-3):0v] = fracmultiply[(bits-3):0v]

  #add in the sum of the hidden bit products to the leading bits of frac_multiply.
  frac_result[(bits * 2 - 5):(bits-2)v] = full_hidden_bit_sum + Wire(Wire(0b00,2), fracmultiply[(2 * bits - 1):(bits-2)v])

  #amend the fraction so that it's shifted and report whether or not it's been shifted
  multiplied_frac = mul_frac_finisher(frac_result, bits)
end

@verilog function mul_frac_trimmer(untrimmed_fraction::Wire, bits_in::Integer, bits_out::Integer)
  @suffix                           "$(bits_in)bit_to_$(bits_out)bit"
  @input untrimmed_fraction         range((bits_in-3) * 2)
  @assert                           bits_in <= bits_out

  product_size = (bits_in-3) * 2
  output_size = bits_out - 3

  if product_size > output_size
    frac_val = untrimmed_fraction[msb:(msb-(output_size-1))v]
    guard_val = untrimmed_fraction[msb-output_size]
    summ_val = (|)(untrimmed_fraction[(msb-(output_size+1)):0v])
  else
    padding_zeros = output_size - product_size
    frac_val = Wire(untrimmed_fraction, padding_zeros * Wire(false))
    guard_val = Wire(false)
    summ_val = Wire(false)
  end

  trimmed_frac = Wire(frac_val, guard_val, summ_val)

end

doc"""
  mul_exp_sum calculates the sum of two biased exponents and rebiases it based
  on the new, desired output.
"""
@verilog function mul_exp_sum(prod_sign::SingleWire, lhs_exp::Wire, rhs_exp::Wire, frac_adjustment::Wire{1:0v}, bits_in::Integer, bits_out::Integer)
  @assert bits_in <= bits_out
  @input lhs_exp             range(regime_bits(bits_in))
  @input rhs_exp             range(regime_bits(bits_in))

  #calculate the destination width.
  # TODO:  incorporate ES bits into this.

  #  Use two padding bits because that enables proper tracking of which values
  # are negative-minimal, and which values are
  tracked_biased_width = max(regime_bits(bits_out), regime_bits(bits_in) + 2)
  input_padding = destination_width - length(lhs_exp)

  #set up an initial variable to hold the adjustment value.

  exponential_bias_adjustment = exp_bias(bits_out) - 2 * exp_bias(bits_in)

  #set up an initial constant wire with this exponential bias adjustment

  if exponential_bias_adjustment < 0
    bias_wire = Wire(-Unsigned(-exponential_bias_adjustment), tracked_biased_width)
  else
    bias_wire = Wire(Unsigned(exponential_bias_adjustment), tracked_biased_width)
  end

  #next add in the lhs and rhs values
  lhs_exp_sum =  bias_wire    + Wire((input_padding * Wire(false)), lhs_exp)
  dual_exp_sum = lhs_exp_sum  + Wire((input_padding * Wire(false)), rhs_exp)
  adj_exp_sum =  dual_exp_sum + Wire((tracked_biased_width - 2) * Wire(false), frac_adjustment)

  #overflow and underflow checking.

  #next we need to check to see if the exponent exceeds the minimum or the maximum.
  minimum_exceeded = adj_exp_sum[msb] | (~prod_sign & (adj_exp_sum == Wire(one(UInt64), tracked_biased_width)))
  #if we're substituting the minimum, the value that applies is !prod_sign.
  #first check to see that it's indeed positive, then check to see that
  maximum_exceeded = (~adj_exp_sum[msb]) & (adj_exp_sum > Wire(max_biased_exp(bits_out), tracked_biased_width)) |
                      (adj_exp_sum[msb]) & (adj_exp_sum > Wire(max_biased_exp(bits_out) - 1, tracked_biased_width))

  output_bits = regime_bits(bits_out)

  #create a panel of substitute values ready to go.
  clipping_value = Wire(output_bits)
  clipping_value[msb:1v] = Wire(max_biased_exp(bits) - 1, output_bits)[msb:1v] & ((output_bits - 1) * ~prod_sign)
  clipping_value[0] = ~prod_sign

  do_exp_clipping = minimum_exceeded | maximum_exceeded

  exp_sum = adj_exp_sum[range(output_bits)] & (output_bits * ~do_exp_clipping) | (clipping_value & (output_bits * do_exp_clipping))
end


doc"""
  posit_multiplier(Wire, Wire, bits_in, bits_out)

  a generated, unpipelined posit multiplier that takes a certain number of bits
  in and outputs a certain number of bits out.
"""
@verilog function posit_extended_multiplier(lhs::Wire, rhs::Wire, bits_in::Integer, bits_out::Integer)
  @assert bits_in <= bits_out
  @suffix "$(bits_in)bit_to_$(bits_out)bit"
  @input lhs range(eposit_size(bits_in))                  #decare that lhs and rhs
  @input rhs range(eposit_size(bits_in))                  #decare that lhs and rhs

  #unpack the extended posit data structure.
  lhs_inf  = lhs[msb]
  lhs_zer  = lhs[msb-1]
  lhs_sgn  = lhs[msb-2]
  lhs_exp  = lhs[(msb-3):(bits_in-2)v]
  lhs_frac = lhs[(bits_in - 3):0v]

  rhs_inf  = rhs[msb]
  rhs_zer  = rhs[msb-1]
  rhs_sgn  = rhs[msb-2]
  rhs_exp  = lhs[(msb-3):(bits_in-2)v]
  rhs_frac = rhs[(bits_in - 3):0v]

  multiplied_frac = mul_frac(lhs_sgn, lhs_frac, rhs_sgn, rhs_frac, bits_in)
  prod_frac = mul_frac_trimmer(multiplied_frac[msb-2:0v], bits_in, bits_out)

  prod_inf = lhs_inf | rhs_inf
  prod_zer = lhs_zer | rhs_zer
  prod_sgn = lhs_sgn ^ rhs_sgn

  prod_exp = mul_exp_sum(prod_sgn, lhs_exp, rhs_exp, prod_frac[msb:(msb-1)v], bits_in, bits_out)

  eproduct = Wire(prod_inf, prod_zer, prod_sgn, prod_exp, prod_frac[msb-2:0v])
end

@verilog function posit_multiplier(lhs::Wire, rhs::Wire, bits_in::Integer, bits_out::Integer)
  @suffix "$(bits_in)bit_to_$(bits_out)bit"
  @input lhs range(bits_in)                  #decare that lhs and rhs
  @input rhs range(bits_in)                  #decare that lhs and rhs

  lhs_extended = posit_decode(lhs)
  rhs_extended = posit_encode(rhs)

  mul_result_extended = posit_extended_multiplier(lhs_extended, rhs_extended, bits_in, bits_out)

  mul_result = posit_encode(mul_result_extended[msb:2v], mul_result_extended[1], mul_result_extended[0], bits_out)
end
