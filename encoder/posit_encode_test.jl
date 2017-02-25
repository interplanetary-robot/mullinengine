#TODO:  Add more tests for individual parts of encoding here.





#comprehensive testing of posit transcoding

for idx = zero(UInt8):(-one(UInt8))
  @test idx == encode_posit(decode_posit(idx, 8), 0b0, 0b0, 8)
end
