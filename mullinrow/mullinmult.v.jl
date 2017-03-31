#mullin multiplication.v.jl - performs a multiplication routine of a specified
#bit size, using a pre-multiplied fraction value.  Later, more routines will
#be included in a "mode" variable.


doc"""
  `mullin_mul` takes a lhs and rhs expanded posit from the mullin engine that has
  already had its product calculated and completes the process of multiplication
  on this value.
"""
@verilog function mullin_mul(lhs_s::Wire{2:0v}, lhs_e::Wire, lhs_f::Wire,
                             rhs_s::Wire{2:0v}, rhs_e::Wire, rhs_f::Wire,
                             raw_m::Wire, bits_in::Integer, bits_out::Integer)

  @suffix           "$(bits_in)_to_$(bits_out)bit"
  @input lhs_e      range(regime_bits(bits_in))
  @input lhs_f      range(bits_in)
  @input rhs_e      range(regime_bits(bits_in))
  @input rhs_f      range(bits_in)
  @input raw_m      range(bits_out)

  lhs_sgn = lhs_s[0]
  rhs_sgn = rhs_s[0]
  lhs_zer = lhs_s[1]
  rhs_zer = rhs_s[1]
  lhs_inf = lhs_s[2]
  rhs_inf = rhs_s[2]

  inp_frac_delta = bits_in - 4

  #set the hidden crossmultiplier values.
  lhs_frac_rhs_sign = mul_frac_hidden_crossmultiplier(rhs_sgn, lhs_f[msb:(msb-inp_frac_delta)v], bits_in)
  rhs_frac_lhs_sign = mul_frac_hidden_crossmultiplier(lhs_sgn, rhs_f[msb:(msb-inp_frac_delta)v], bits_in)

  #first, create a wire that's the hidden bits merged with the fraction bits.
  top_hidden_bit = lhs_sgn ^ rhs_sgn
  next_hidden_bit = ~(lhs_sgn | rhs_sgn)

  general_mul_result = Wire(top_hidden_bit, next_hidden_bit, raw_m)
  lhs_sum_result = lhs_frac_rhs_sign + general_mul_result[msb:(msb - inp_frac_delta - 2)v]
  full_sum_result = Wire(rhs_frac_lhs_sign + lhs_sum_result, general_mul_result[(msb - inp_frac_delta - 3):6v])

  #amend the fraction so that it's shifted and report whether or not it's been shifted
  (frac_report, shifted_frac) = mul_frac_finisher(top_hidden_bit, full_sum_result, bits_in * 2 - 4)

  provisional_prod_frac = mul_frac_trimmer(shifted_frac, bits_in * 2 - 5, bits_out)

  prod_sgn = lhs_inf | rhs_inf
  prod_s = Wire(prod_sgn, lhs_zer | rhs_zer, lhs_sgn ^ rhs_sgn)

  extended_prod_exp = mul_exp_sum(prod_sgn, lhs_e, rhs_e, frac_report, bits_in, bits_out)

  #we may want to do this slightly better in the future.
  prod_exp, prod_frc_short = exp_trim(prod_sgn, extended_prod_exp, provisional_prod_frac, bits_out, :mul)
  prod_frc = Wire(prod_frc_short, Wire(0x00, 3))

  (prod_s, prod_exp, prod_frc)
end
