#tests to see if p2b8 works.

function encode_posit8_wrapper(mb::mullin_buff8)
  isinf = UInt8((mb.s & 0x04) != 0)
  iszer = UInt8((mb.s & 0x02) != 0)
  sgn   = UInt8((mb.s & 0x01) != 0)

  encode_posit(isinf, iszer, sgn, Unsigned(mb.e), (mb.f >> 3), 0x00, 8)
end

@time begin
print("testing posit logical (non-wire) decoding...")
for posit = 0x00:0xFF
  @test encode_posit8_wrapper(p2b8(posit)) == posit
end
println("OK")
end

@time begin
print("testing posit logical (non-wire) encoding...")
for p16 = 0x0000:0x0080
  #create the 8-bit rounded posit.
  p8 = SigmoidNumbers.__round(reinterpret(Posit{8,0}, Posit{16,0}(p16)))
  #create a wire that corresponds to this.
  pwire = Wire{15:0v}(p16)
  decoded_posit = decode_posit(pwire, 16)
  s = UInt8(Unsigned(decoded_posit[20:18v]))
  e = UInt8(Unsigned(decoded_posit[17:13v]))
  f = UInt16(Unsigned(decoded_posit[12:0v])) << 3
  p16struct = mullin_buff16(s, e, f, 0x0)
  @test (Posit{8,0}(b16_2p8(p16struct)), p16) == (p8, p16)
end
println("OK")
end
