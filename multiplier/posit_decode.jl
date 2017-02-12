##posit_decode.jl

function decodeposit(value::UInt16)
  sign = (value & 0x8000) != 0
  inv =  (value & 0x4000) == 0
  actually_inv = sign $ inv
  shift = (inv ? leading_zeros(value & 0x7FFF) : leading_ones(value | 0x8000)) - 2
  regime = (inv ? leading_zeros(value & 0x7FFF) + 1 : leading_ones(value | 0x8000)) - 2
  println("regime: ", regime)
  biased_exponent = 15 + (actually_inv ? -regime : regime) - sign
  println("biased exponent: ", biased_exponent)
  shifted_fraction = value << (shift + 3)
  fracstring = bits(shifted_fraction)[1:13]
  println("fraction: ", fracstring)
  println("binary form: 0 0 ", sign ? "1 " : "0 ", bits(biased_exponent)[end-4:end], " ", fracstring)
  hexform = UInt32(shifted_fraction >> 3)
  hexform |= UInt32(biased_exponent) << 13
  hexform |= UInt32(sign) << 18
  println(bits(hexform)[12:32])
  println("hex:", hex(hexform))
end
