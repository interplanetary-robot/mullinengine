##posit_decode.jl

function decodeposit(value::UInt8)
  sign = (value & 0x80) != 0
  inv =  (value & 0x40) == 0
  actually_inv = sign $ inv
  shift = (inv ? leading_zeros(value & 0x7F) : leading_ones(value | 0x80)) - 2
  regime = (inv ? leading_zeros(value & 0x7F) + 1 : leading_ones(value | 0x80)) - 2
  println("regime: ", regime)
  biased_exponent = 7 + (actually_inv ? -regime : regime) - sign
  println("biased exponent: ", biased_exponent)
  shifted_fraction = value << (shift + 3)
  fracstring = bits(shifted_fraction)[1:5]
  println("fraction: ", fracstring)
  println("binary form: 0 0 ", sign ? "1 " : "0 ", bits(biased_exponent)[end-3:end], " ", fracstring)
  hexform = UInt16(shifted_fraction >> 3)
  hexform |= UInt16(biased_exponent) << 5
  hexform |= UInt16(sign) << 9
  println(bits(hexform)[5:16])
  println("hex:", hex(hexform))
end
