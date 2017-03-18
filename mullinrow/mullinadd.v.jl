
@verilog function mullin_add_augment(sgn::SingleWire, frc::Wire, bits::Integer)
  @suffix         "$(bits)"
  @input frc      range(bits)

  should_carry = (frc[1] & frc[2]) | (frc[2] & frc[3])
  rounded_frc  = frc[msb:3v] + Wire(Wire(zero(UInt64), bits-4), should_carry)
  augmented_frc = Wire(sgn, ~sgn, rounded_frc, Wire(false))
end


@verilog function mullin_frc_add(acc_s::Wire{2:0v}, acc_e::Wire, acc_f::Wire,
                                 mul_s::Wire{2:0v}, mul_e::Wire, mul_f::Wire, bits::Integer)

  @suffix           "$(bits)"
  @input acc_e      range(regime_bits(bits))
  @input acc_f      range(bits)
  @input mul_e      range(regime_bits(bits))
  @input mul_f      range(bits)

  #pull out the zero and sign bits from the states of the accumulator and the multiplier.
  acc_zer = acc_s[1]
  mul_zer = mul_s[1]
  acc_sgn = acc_s[0]
  mul_sgn = mul_s[0]

  #create augmented accumulator and multiplier fractions.  This also rounds them.
  a_acc_f = mullin_add_augment(acc_sgn, acc_f, bits)
  a_mul_f = mullin_add_augment(mul_sgn, mul_f, bits)

  #zero it out if the corresponding side is zero.
  z_acc_f = a_acc_f & (bits * (~acc_zer))
  z_mul_f = a_mul_f & (bits * (~mul_zer))

  #the acc_dom_frac is going to also be used for "other types of multiplication"
  acc_wins, acc_dom_exp, acc_dom_frc = add_theoretical(acc_e, z_acc_f, mul_e, z_mul_f, bits)
  mul_wins, mul_dom_exp, mul_dom_frc = add_theoretical(mul_e, z_mul_f, acc_e, z_acc_f, bits)

  res_sgn = (acc_wins & acc_sgn) | (mul_wins & mul_sgn) | (acc_sgn & mul_sgn)
  res_exp = acc_dom_exp          | mul_dom_exp
  res_frc = acc_dom_frc          | mul_dom_frc

  (res_sgn, res_exp, res_frc)
end

@verilog function mullin_addition_state(acc_s::Wire{2:0v}, mul_s::Wire{2:0v}, sum_sgn::SingleWire, sum_zerocheck::SingleWire)
  acc_inf = acc_s[2]
  mul_inf = mul_s[2]
  acc_zer = acc_s[1]
  mul_zer = mul_s[1]

  sum_inf  = acc_inf | mul_inf
  #nan if both sides are inf, or if either side propagates a NaN.
  sum_nan = (acc_inf & mul_inf) | ((acc_inf & acc_zer) | (mul_inf & mul_zer))

  sum_zer = ((acc_zer & mul_zer) | sum_zerocheck) | sum_nan

  Wire(sum_inf, sum_zer, sum_sgn)
end

doc"""
  mullin_addition_cleanup

  cleans up addition so that the results are correct.
"""
@verilog function mullin_addition_cleanup(sgn::Wire{0:0v}, provisional_exp::Wire, provisional_frc::Wire, bits::Integer)
  @input provisional_exp      range(regime_bits(bits))
  @input provisional_frc      range(bits + 1)

  #extract a one-hot shift analysis from the provisional sum.
  frc_shift_onehot = add_shift_onehot(sgn, provisional_frc, bits)

  sum_frc_untrimmed = add_apply_shift(provisional_frc, frc_shift_onehot, bits)

  #calculate the exponent difference that will happen due to a shift.  For
  #addition, this could be no change or +1 due to carry; for subtraction, this
  #could be no change or -(arbitrary amount).
  sum_exp_diff = add_shift_diff(frc_shift_onehot, bits)

  #apply this difference to the provisional exponent.
  sum_exp_untrimmed = add_exp_diff(provisional_exp, sum_exp_diff, bits)


  #trim overflow and underflow exponents
  (sum_exp, sum_frc_trimmed, sum_gs) = exp_trim(sgn, sum_exp_untrimmed, sum_frc_untrimmed, bits, :add)

  sum_frc = Wire(sum_frc_trimmed, sum_gs, Wire(false))

  #NB: in the future, this will also need to send error flags to the processor.
  (sum_exp, sum_frc)
end
