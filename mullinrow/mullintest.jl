#mullintest.jl  -test stuff for mullin engine components

#test mullin mul.

doc"""
  wraps mullin_mul so that you can call it as fused wires.
"""
@verilog function mullin_mul_wrapper(lhs::Wire{7:0v}, rhs::Wire{7:0v})
  lhs_dec = posit_decode(lhs)
  rhs_dec = posit_decode(rhs)

  result_s, result_f = mullin_mul(lhs[10:9v], lhs[8:5v], lhs[4:0v],
                                  rhs[10:9v], rhs[8:5v], rhs[8:5v], 8, 16)

  rhs_dec
end

@verilog function frac_stripper(lhs::Wire{15:0v})
  stripped = posit_decode(lhs)
  result = stripped[12:0v]
end

#@test mullin_mul_wrapper(0b0100_0000, 0b0100_0000) == frac_stripper(0x4000) << 3
