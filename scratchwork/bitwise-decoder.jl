#bitwise-decoder.jl
# a quick utility that makes bitwise decoding conversions a helluva lot easier.

using SigmoidNumbers

fractionbits(n) = (n - 3)
rightshift(n) = 64 - fractionbits(n)
bias(n) = n - 2

function bitwisedecode{N}(x::Posit{N,0})

  negative = reinterpret(Int64, x) < 0

  x = (negative) ? -x : x

  u = reinterpret(UInt64, x)

  inverted = ((u & 0x4000_0000_0000_0000) == 0)

  if (inverted)
    regime = leading_zeros(u) - 1
  else
    regime = leading_ones(u | 0x8000_0000_0000_0000) - 1
  end
  println("regime: ", regime)

  f = (u << (regime + 2))
  fstring = bits(f)[1:N-3]
  println("fraction: ", fstring)
  vsofar = f >> rightshift(N)

  exponentbits = Integer(log2(N)) + 1
  unbiasedexponent = inverted ? (-regime) : (regime - 1)
  println("exponent: ", unbiasedexponent)
  biasedxp = bias(N) + unbiasedexponent
  println("biasedxp: ", biasedxp)
  estring = bits(biasedxp)[end - exponentbits + 1:end]

  vsofar |= biasedxp << fractionbits(N)
  vsofar |= negative ? (1 << (fractionbits(N) + exponentbits)) : 0

  println(negative ? "1 " : "0 ", join([estring, fstring], " "))

  hex(vsofar)
end
