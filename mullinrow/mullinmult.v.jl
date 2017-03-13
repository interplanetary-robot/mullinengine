#mullin multiplication.v.jl - performs a multiplication routine of a specified
#bit size, using a pre-multiplied fraction value.  Later, more routines will
#be included in a "mode" variable.

doc"""
  `mullin_mul` takes a lhs and rhs expanded posit from the mullin engine that has
  already had its product calculated and completes the process of multiplication
  on this value.
"""
@verilog function mullin_mul(lhs_s::State, lhs_e::Wire, lhs_f::Wire, rhs_s::State, rhs_e::Wire, rhs_f::Wire, raw_m::Wire, size_in::Integer, size_out::Integer)
  @suffix           "$(size_in)_$(size_out)"
  @input lhs_e      range(regimebits(size_in))
  @input lhs_f      range(size_in)
  @input rhs_e      range(regimebits(size_in))
  @input rhs_f      range(size_in)
  @input raw_m      range(size_in * size_in)

  inp_frac_delta = size_in - 2
  #set the hidden crossmultiplier values.
  lhs_frac_rhs_sign = mul_frac_hidden_crossmultiplier(rhs_sign, lhs_frac[msb:(msb-inp_frac_delta)v], bits)
  rhs_frac_lhs_sign = mul_frac_hidden_crossmultiplier(lhs_sign, rhs_frac[msb:(msb-inp_frac_delta)v], bits)

  #calculate the hidden bits for the multiplied fraction.
  raw_mult_hidden_bits = Wire(lhs_sign ^ rhs_sign, ~(lhs_sign | rhs_sign), raw_m[msb:(msb - inp_frac_delta)v])

  #add the hidden bits to the lhs_frac (this is the "first addition")
  first_addition = raw_mult_hidden_bits + lhs_frac_rhs_sign
  second_addition = first_addition + rhs_frac_lhs_sign

  #final fraction result concatenates the rest of the raw multiply result.
  mul_frac_unshifted = Wire(second_addition, raw_m[msb:(msb - (inp_frac_delta + 1))v])

  mul_shift, mul_frac = mul_frac_finisher(raw_mult_hidden_bits[1], mul_frac_unshifted, bits)

  #TODO: This needs to be cleaned up a bit.
  multiplied_frac = Wire(mul_shift, mul_frac)

  


end
