#TODO:  Add more tests for individual parts of encoding here.

#comprehensive testing of posit transcoding

print("testing posit transcoding...")
for idx = zero(UInt8):(-one(UInt8))
  @test idx == encode_posit(decode_posit(idx, 8) << 2, 8)
end
println("OK!")
