#mullintest.jl  -test stuff for mullin engine components

#test mullin mul.

doc"""
  wraps mullin_mul so that you can call it as fused wires.
"""
@verilog function mullin_mul_wrapper(lhs::Wire{7:0v}, rhs::Wire{7:0v})
  lhs_dec = posit_decode(lhs)
  rhs_dec = posit_decode(rhs)

  #generate a the muliply fraction, like the mullin engine does.
  mul_frc = Wire(lhs, Wire(0x0, 3)) * Wire(rhs, Wire(0x0, 3))

  #perform mullin_mul
  mul_s, mul_e, mul_f = mullin_mul(lhs[10:9v], lhs[8:5v], lhs[4:0v],
                                   rhs[10:9v], rhs[8:5v], rhs[4:0v],
                                   mul_frc, 8, 16)

  mul_fr = mul_f[msb:msb-12]
  mul_gs = mul_f[2:1v]

  rhs_dec = posit_encode(mul_s, mul_e, mul_fr, mul_gs, 16)
end

#test this comprehensively.
print("testing mullin multiplier...")
@time for lhs = 0x00:0xFF
  for rhs = 0x00:0xFF
    res = mullin_mul_wrapper(lhs, rhs) << 48

    lhs_s = reinterpret(Posit{8,0}, lhs)
    rhs_s = reinterpret(Posit{8,0}, rhs)

    @test SigmoidNumbers.__round(res) == lhs_s * rhs_s
  end
end
println("OK.")
