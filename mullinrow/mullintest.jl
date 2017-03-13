#mullintest.jl  -test stuff for mullin engine components

#test mullin mul.

doc"""
  wraps mullin_mul so that you can call it as fused wires.
"""
@verilog function mullin_mul_wrapper(lhs::Wire{7:0v}, rhs::Wire{7:0v})
  lhs_dec = decode_posit(lhs, 8)
  rhs_dec = decode_posit(rhs, 8)

  lhs_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3))
  rhs_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3))

  #generate a the muliply fraction, like the mullin engine does.
  mul_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3)) * Wire(rhs_dec[4:0v], Wire(0x0, 3))

  #perform mullin_mul
  mul_s, mul_e, mul_f = mullin_mul(lhs_dec[11:9v], lhs_dec[8:5v], lhs_frc,
                                   rhs_dec[11:9v], rhs_dec[8:5v], rhs_frc,
                                   mul_frc, 8, 16)

  mul_gs = Wire(0x0, 2)

  rhs_dec = encode_posit(mul_s[2], mul_s[1], mul_s[0], mul_e, mul_f, mul_gs, 16)
end

#=
#test this comprehensively.
print("testing mullin multiplier...")
@time for lhs = 0x00:0xFF
  for rhs = 0x00:0xFF
    res = mullin_mul_wrapper(lhs, rhs) << 48

    lhs_s = reinterpret(Posit{8,0}, UInt64(lhs))
    rhs_s = reinterpret(Posit{8,0}, UInt64(rhs))

    try
      res = lhs_s * rhs_s
    catch
      continue
    end
    @test (SigmoidNumbers.__round(reinterpret(Posit{8,0},res)), lhs, rhs) == (res, lhs, rhs)
  end
end
println("OK.")
=#
