#tests to see if p2b8 works.

function encode_posit8_wrapper(mb::mullin_buff8)
  isinf = UInt8((mb.s & 0x04) != 0)
  iszer = UInt8((mb.s & 0x02) != 0)
  sgn   = UInt8((mb.s & 0x01) != 0)

  encode_posit(isinf, iszer, sgn, Unsigned(mb.e), (mb.f >> 3), 0x00, 8)
end

for posit = 0x00:0xFF
  @test encode_posit8_wrapper(p2b8(posit)) == posit
end

#the next important thing is doing the reverse experiment:  b16_2p8
#the b16 output is encoded as a uint32.
#layout:
# |  state  |  exponent  |  fraction  |
# |         |            |
