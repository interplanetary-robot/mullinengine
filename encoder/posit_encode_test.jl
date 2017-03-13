#TODO:  Add more tests for individual parts of encoding here.

#comprehensive testing of posit transcoding

function encode_posit_integer_shim(shimval::UInt64)
  shim = Wire(shimval, 12)
  inf   = shim[11]
  zer   = shim[10]
  sgn   = shim[9]
  exp   = shim[8:5v]
  frac  = shim[4:0v]
  gs    = Wire(0x0, 2)
  (inf, zer, sgn, exp, frac, gs)
end

print("testing posit transcoding...")
for idx = zero(UInt8):(-one(UInt8))
  @test idx == Unsigned(encode_posit(encode_posit_integer_shim(decode_posit(idx, 8))..., 8))
end
println("OK!")
