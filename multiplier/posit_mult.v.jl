
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
  selected_inv_frac = inv_frac & ((bits - 3) * crosssign)
  selected_frac     = frac & ((bits - 3) * ~crosssign)
  result = Wire(top_neg, selected_inv_frac[msb], (selected_inv_frac[msb-1:0v] | selected_frac[msb:1v]), selected_frac[0])
end

doc"""
  mul_frac_finisher()

  finishes up work on the fraction side.  Effectively, this looks at the reported
  'provisional fraction' result and reports a fraction value that's got on its
  MSB special instructions on how to augment the exponent.
"""
@verilog function mul_frac_finisher(final_sign::SingleWire, provisional_fraction::Wire, provisional_size::Integer)
  @suffix                               "$(bits)bit"
  @input provisional_fraction           range(provisional_size)

  shift_selector = final_sign ^ provisional_fraction[msb]

  exponent_augment = Wire(2)
  exponent_augment[1] = (~(provisional_fraction[msb] | provisional_fraction[msb-1])) & (~final_sign)  #take the top two for this value.
  exponent_augment[0] = shift_selector

  selected_one_shift_fraction = ((provisional_size - 1) * shift_selector)  & provisional_fraction[(msb-1):0v]
  selected_two_shift_fraction = ((provisional_size - 1) * ~shift_selector) & Wire(provisional_fraction[(msb-2):0v], Wire(false))
  shifted_fraction = selected_one_shift_fraction | selected_two_shift_fraction

  (exponent_augment, shifted_fraction)
end

doc"""

  mul_frac(SingleWire, Wire, SingleWire, Wire, bits_in)

  performs a fraction multiplication.  Outputs:

  | exponent_augment | MSB  ...fraction...  LSB |
  |       2 bits     |          f bits          |

  where f is length(lhs_frac) + length(rhs_frac) + 1

"""
@verilog function mul_frac(lhs_sign::SingleWire, lhs_frac::Wire, rhs_sign::SingleWire, rhs_frac::Wire, bits::Integer)
  @suffix "$(bits)bit"
  @input lhs_frac        range(bits - 3)
  @input rhs_frac        range(bits - 3)

  lhs_frac_rhs_sign = mul_frac_hidden_crossmultiplier(rhs_sign, lhs_frac, bits)
  rhs_frac_lhs_sign = mul_frac_hidden_crossmultiplier(lhs_sign, rhs_frac, bits)

  top_hidden_bit = lhs_sign ^ rhs_sign
  next_hidden_bit = ~(lhs_sign | rhs_sign)

  #do the basic binary multiply.
  mul_big_frac = lhs_frac * rhs_frac

  #first, create a wire that's the hidden bits merged with the fraction bits.
  general_mul_result = Wire(top_hidden_bit, next_hidden_bit, mul_big_frac)
  lhs_sum_result = lhs_frac_rhs_sign + general_mul_result[msb:(bits-3)v]
  full_sum_result = Wire(rhs_frac_lhs_sign + lhs_sum_result, general_mul_result[(bits-4):0v])

  #amend the fraction so that it's shifted and report whether or not it's been shifted
  (frac_report, shifted_frac) = mul_frac_finisher(top_hidden_bit, full_sum_result, bits*2 - 4)

  (frac_report, shifted_frac)
end

@verilog function mul_frac_trimmer(untrimmed_fraction::Wire, bits_in::Integer, bits_out::Integer)
  @suffix                           "$(bits_in)bit_to_$(bits_out)bit"
  @input untrimmed_fraction         range(bits_in)

  output_size = bits_out - 3

  if bits_in > output_size
    frac_val = untrimmed_fraction[msb:(msb-(output_size-1))v]
    guard_val = untrimmed_fraction[msb-output_size]
    summ_val = (|)(untrimmed_fraction[(msb-(output_size+1)):0v])
  else
    padding_zeros = output_size - bits_in
    frac_val = Wire(untrimmed_fraction, padding_zeros * Wire(false))
    guard_val = Wire(false)
    summ_val = Wire(false)
  end

  trimmed_frac = Wire(frac_val, guard_val, summ_val)

end

doc"""
  mul_exp_sum calculates the sum of two biased exponents and rebiases it based
  on the new, desired output.  Also outputs a bit that signifies if the fraction
  needs to be cleared.

  | clear_bit | MSB    ...exponent...    LSB |
  |   1 bit   |     regime_bits(bits_in)     |

"""
@verilog function mul_exp_sum(prod_sign::SingleWire, lhs_exp::Wire, rhs_exp::Wire, frac_adjustment::Wire{1:0v}, bits_in::Integer, bits_out::Integer)
  @assert bits_in <= bits_out
  @input lhs_exp             range(regime_bits(bits_in))
  @input rhs_exp             range(regime_bits(bits_in))

  #calculate the destination width.
  # TODO:  incorporate ES bits into this.

  #  Use two padding bits because that enables proper tracking of which values
  # are negative-minimal, and which values are
  tracked_biased_width = regime_bits(bits_out) + 2
  input_padding = tracked_biased_width - length(lhs_exp)

  #set up an initial variable to hold the adjustment value.

  exponential_bias_adjustment = regime_bias(bits_out) - 2 * regime_bias(bits_in)
#  println("exponential_bias_adjustment:", exponential_bias_adjustment)

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
end

doc"""
  posit_extended_multiplier(lhs, rhs, bits_in, bits_out)

  a generated, unpipelined posit multiplier that takes an expanded posit
  corresponding to the bits_in size and outputs the result in the form of an
  expanded posit correpsonding to the bits_out size, plus a guard bit and and
  an extended summary bit.
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
  lhs_exp  = lhs[(msb-3):(bits_in-3)v]
  lhs_frac = lhs[range(bits_in - 3)]

  rhs_inf  = rhs[msb]
  rhs_zer  = rhs[msb-1]
  rhs_sgn  = rhs[msb-2]
  rhs_exp  = rhs[(msb-3):(bits_in-3)v]
  rhs_frac = rhs[range(bits_in-3)]

  (frac_report, multiplied_frac) = mul_frac(lhs_sgn, lhs_frac, rhs_sgn, rhs_frac, bits_in)

  provisional_prod_frac = mul_frac_trimmer(multiplied_frac, (bits_in * 2 - 5), bits_out)

  prod_inf = lhs_inf | rhs_inf
  prod_zer = lhs_zer | rhs_zer
  prod_sgn = lhs_sgn ^ rhs_sgn

  extended_prod_exp = mul_exp_sum(prod_sgn, lhs_exp, rhs_exp, frac_report, bits_in, bits_out)

  prod_exp, prod_frac, prod_gs = exp_trim(prod_sgn, extended_prod_exp, provisional_prod_frac, bits_out, :mul)

  (prod_inf, prod_zer, prod_sgn, prod_exp, prod_frac, prod_gs)
end

@verilog function posit_multiplier(lhs::Wire, rhs::Wire, bits_in::Integer, bits_out::Integer)

  @assert ispow2(bits_in)
  @assert ispow2(bits_out)

  @suffix "$(bits_in)bit_to_$(bits_out)bit"
  @input lhs range(bits_in)                  #decare that lhs and rhs
  @input rhs range(bits_in)                  #decare that lhs and rhs

  lhs_extended = decode_posit(lhs, bits_in)

  rhs_extended = decode_posit(rhs, bits_in)

  res_inf, res_zer, res_sgn, res_exp, res_frac, res_gs = posit_extended_multiplier(lhs_extended, rhs_extended, bits_in, bits_out)

  mul_result = encode_posit(res_inf, res_zer, res_sgn, res_exp, res_frac, res_gs, bits_out)

  mul_result
end
