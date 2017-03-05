
doc"""
  `add_shift_value(shift_onehot, bits)`
  converts a one-hot representation of the shift value to a binary difference:

  | MSB    ...exp_diff...    LSB |
  |      esize(bits)+1 bits      |

  NB: this may be replaced by a direct encoding algorithm.
"""
@verilog function add_shift_diff(shift_onehot::Wire, bits)
  @suffix                 "$(bits)bit"
  @input shift_onehot     range(bits-1)
  #biased one-hot-shift:  0 - shift left one
  #                       1 - no shift
  #                       2 - shift right one

  exponent_delta = Wire(regime_bits(bits) + 1)
  #exponent_delta[0] is special.
  exponent_delta[0] = |(Wire([shift_onehot[idx] for idx in range(bits-1) if iseven(idx)]...))

  for idx in 1:(regime_bits(bits)-1)
    #populate the appropriate value from the one-hot lines.  This should be a
    #binary version of the negative one-hot value.
    exponent_delta[idx] = |(Wire([shift_onehot[jdx + 1] for jdx in 1:(bits-3) if bitof(-jdx, idx)]...))
  end

  exponent_delta[msb] = ~(shift_onehot[0] | shift_onehot[1])

  exponent_delta
end

@verilog function add_apply_shift(fraction::Wire, shift_onehot::Wire, bits)
  @suffix                 "$(bits)bit"
  @input fraction         range(bits)
  @input shift_onehot     range(bits-1)
  #biased one-hot-shift:  0 - shift left one
  #                       1 - no shift
  #                       2 - shift right one

  #set up a shifted fraction result.
  shifted_fraction = Wire(bits-3)
  #all the other cases are right-shifted.  Amount specified by index.

  #basic outline:
  #shifted_fraction[0] = (shift_onehot[0] & fraction[1]) | (shift_onehot[1] & fraction[0])
  #shifted_fraction[1] = (shift_onehot[0] & fraction[2]) | (shift_onehot[1] & fraction[1]) | (shift_onehot[2] & fraction[0])
  #shifted_fraction[2] = (shift_onehot[0] & fraction[3]) | (shift_onehot[1] & fraction[2]) | (shift_onehot[2] & fraction[1]) | (shift_onehot[3] & fraction[0])

  for idx in 1:bits-4
    shifted_fraction[idx] = |(Wire([shift_onehot[jdx] & fraction[idx + 1 - jdx] for jdx = 0:idx+1]...))
  end

  shifted_fraction
end

doc"""
  `add_shift_onehot(sign, provisional_sum_frac, bits)`
  analyzes the provisional sum fraction and ouputs a one-hot encoding of the
  shift value.  The encoding is as follows:

  line 0: shift left one
  line 1: no shift
  line 2: shift right one
  line 3: shift right two
  etc.

  NB: this may be replaced by a direct encoding algorithm.
"""
@verilog function add_shift_onehot(sign::SingleWire, provisional_sum_frac::Wire, bits)
  @suffix                      "$(bits)bit"
  @input provisional_sum_frac  range(bits-1)

  sumvalue = provisional_sum_frac ^ ((bits - 1) * sign)

  leading_onehot = Wire(bits-1)
  #generates a one-hot encoding of the number of leading bits.
  #lcount_lines[0] = sumvalue[msb]
  #lcount_lines[1] = ~sumvalue[msb] & sumvalue[msb-1]
  #lcount_lines[2] = ~(sumvalue[msb] | sumvalue[msb-1]) & sumvalue[msb-2]
  #lcount_lines[3] = ~(|(sumvalue[msb], sumvalue[msb-1], sumvalue[msb-2])) & sumvalue[msb-3]
  leading_onehot[0] = sumvalue[msb]
  for idx in 1:bits-2
    leading_onehot[idx] = ~(|(Wire([sumvalue[msb-j] for j in range(idx)]...))) & sumvalue[msb-idx]
  end
  leading_onehot
end

@verilog function add_theoretical(dom_exp::Wire, dom_frac::Wire, sub_exp::Wire, sub_frac::Wire, bits)
  @suffix             "$(bits)bit"
  #we are going to assume that the dominant exponent wins out (but that may not necssarily be true)
  @input dom_exp      range(regime_bits(bits))
  @input dom_frac     range(bits)
  @input sub_exp      range(regime_bits(bits))
  @input sub_frac     range(bits)

  edom_exp = Wire(Wire(false), dom_exp)
  esub_exp = Wire(Wire(false), sub_exp)

  sum_exp = edom_exp - esub_exp
  nuke_me = sum_exp[msb]
  shift = sum_exp[(msb-1):0v]

  shft_sub_frac = sub_frac >>> shift

  #add the two fractions together.
  sum_frac = dom_frac + shft_sub_frac

  #return the values added together in this hypothetical universe concatenated
  #with an indicator telling us if 'this side won'.
  provisional_sum = Wire(Wire(true), dom_exp, sum_frac) & ((bits + regime_bits(bits) + 1) * (~nuke_me))
end


@verilog function add_zero_checker(lhs_sgn::SingleWire, lhs_exp::Wire, lhs_frac::Wire, rhs_sgn::SingleWire, rhs_exp::Wire, rhs_frac::Wire, bits::Integer)
  @suffix             "$(bits)bit"
  @input lhs_exp      range(eposit_size(bits_in) - 3)
  @input rhs_exp      range(eposit_size(bits_in) - 3)

  augmented_lhs = Wire((regime_bits(bits) - 1) * Wire(false), lhs_sgn) + lhs_exp
  augmented_rhs = Wire((regime_bits(bits) - 1) * Wire(false), rhs_sgn) + rhs_exp
  #check to make sure that augmented_lhs == augmented_rhs
  exp_match = (~|)(augmented_lhs ^ augmented_rhs)

  #they should sum to zero, which we check by nor'ing.
  frac_match = (~|)(lhs_frac + rhs_frac)

  iszero = (lhs_sgn ^ rhs_sgn) & (exp_match & frac_match)
end


@verilog function posit_extended_adder(lhs_e::Wire, rhs_e::Wire, bits::Integer)
  @suffix             "$(bits)bit"
  @input lhs_e        range(eposit_size(bits_in))
  @input rhs_e        range(eposit_size(bits_in))

  #unpack the extended posit data structure.
  lhs_inf  = lhs_e[msb]
  lhs_zer  = lhs_e[msb-1]
  lhs_sgn  = lhs_e[msb-2]
  lhs_exp  = lhs_e[(msb-3):(bits_in-3)v]
  lhs_frac = lhs_e[range(bits_in - 3)]

  rhs_inf  = rhs_e[msb]
  rhs_zer  = rhs_e[msb-1]
  rhs_sgn  = rhs_e[msb-2]
  rhs_exp  = rhs_e[(msb-3):(bits_in-3)v]
  rhs_frac = rhs_e[range(bits_in-3)]

  #deal with the status bits.
  sum_inf  = lhs_inf | rhs_inf
  sum_nan  = (lhs_inf & rhs_inf) | ((lhs_inf & lhs_zer) | (rhs_inf & rhs_zer))
  sum_zer1 = lhs_zer & rhs_zer
  sum_zer2 = add_zero_checker(lhs_sgn, lhs_exp, lhs_frac, rhs_sgn, rhs_exp, rhs_frac, bits)
  sum_zer = (sum_zer1 | sum_zer2) | sum_nan

  #create the augmented fractions (contains hidden bits, plus a guard bit.)
  lhs_aug_frac = Wire(lhs_sgn, ~lhs_sgn, lhs_frac, Wire(false))
  rhs_aug_frac = Wire(rhs_sgn, ~rhs_sgn, rhs_frac, Wire(false))

  parallel_universe_lhs_dom = add_theoretical(lhs_exp, lhs_aug_frac, rhs_exp, rhs_aug_frac, bits)
  parallel_universe_rhs_dom = add_theoretical(rhs_exp, rhs_aug_frac, lhs_exp, lhs_aug_frac, bits)

  #the top bit of the "provisional sum" says whether this exponent wound up negative,
  #so we should mix that in with the "other" sign.  It's possible that this is zero
  #because both rhs_sgn and lhs_sgn are zero (the exponents were the same).
  sum_exp_sgn = (parallel_universe_lhs_dom[msb] & rhs_sgn) | (parallel_universe_rhs_dom[msb] & lhs_sgn)

  #the provisional sum combines the exponent and fraction parts and are selected
  #the validity of the value.
  provisional_sum = parallel_universe_lhs_dom[(msb-1):0v] | parallel_universe_rhs_dom[(msb-1):0v]
  provisional_frc = provisional_sum[(bits-1):0v]
  provisional_exp = provisional_sum[(msb-1):bits]

  #we can extract the top bit from the provisional sum to determine the sign in
  #the case that the exponents were the same.
  sum_frc_sgn = ~(parallel_universe_lhs_dom[msb] ^ parallel_universe_rhs_dom[msb]) & provisional_sum[msb]

  sum_sgn = sum_exp_sgn | sum_frc_sgn

  #extract a one-hot shift analysis from the provisional sum.
  frc_shift_onehot = add_shift_onehot(sum_sgn, provisional_sum[(bits-1):1v], bits)

  #shift the fraction
  sum_frc_untrimmed = add_apply_shift(shift_onehot, bits)

  sum_exp_diff = add_shift_diff(shift_onehot, bits)

  sum_exp_untrimmed = add_exp_diff(sum_exp, sum_exp_diff, bits)

  #trim with a padding of one.
  sum_expfrc_trimmed = exp_trim(sum_exp_untrimmed, sum_frc_untrimmed, bits, :add)

end


@verilog function posit_adder(lhs::Wire, rhs::Wire, bits::Integer)
  @suffix             "$(bits)bit"
  @input lhs          range(bits)
  @input rhs          range(bits)

  lhs_extended = decode_posit(lhs, bits)

  rhs_extended = decode_posit(rhs, bits)

  add_result_extended = posit_extended_adder(lhs_extended, rhs_extended, bits)

  #no guard and summary bits for add_result.  (figure this out later)
  add_result = encode_posit(add_result_extended[msb:0v], bits)

  add_result
end
