@verilog function set_inf_zero_bits(
  signbit::SingleWire,
  allzeros::SingleWire)

  result = Wire(allzeros & signbit, allzeros & (~signbit))
end

@verilog function set_one_hot_shift(posit::Wire, bits::Integer)
  @name_suffix        "$(bits)_bit"
  #describe the incoming posit wire.
  @wire posit         range(bits)

  xorlines  = posit[(bits-3):0v] ^ ((bits - 2) * posit[bits-2])
  xnorlines = ~xorlines

  result = Wire(bits-1)

  result[0] = and(xnorlines[(bits-3):0v])
  for bit = 1:(bits-3)
    result[bit] = and(Wire(xorlines[bit-1], xnorlines[(bits-3):(bit)v]))
  end
  result[bits-2] = xorlines[bits-3]

  result
end

@verilog function set_fraction(posit::Wire, one_hot_shifts::Wire, bits::Integer)
  #describe the incoming posit wire.
  @name_suffix                  "$(bits)_bits"
  @wire posit                   range(bits)
  @wire one_hot_shifts          range(bits-1)

  result = Wire(bits-3)

  for bit in range(bits-3)
    result[bit] = |(one_hot_shifts[(bits-2):(bits-2-bit)v] & posit[bit:0v])
  end

  result
end

@verilog function set_one_hot_regime(inverted::Wire{1:0v}, one_hot_shifts::Wire, bits::Integer)
  @name_suffix                  "$(bits)_bits"
  @wire one_hot_shifts          range(bits-1)

  #calculate the maximum one-hot value.
  one_hot_max = (2 * bits - 3)
  result = Wire(one_hot_max:1v)

  result[(bits-2):1v]             = ((bits - 2) * inverted[1]) & one_hot_shifts[(bits  -2):1v]
  result[(one_hot_max):(bits-1)v] = ((bits - 1) * inverted[0]) & one_hot_shifts[0:(bits - 2)v]

  result
end

regime_bits(n::Integer) = Integer(ceil(log2(n))) + 1

@verilog function set_binary_regime(one_hot_regime::Wire, bits::Integer)
  @name_suffix                  "$(bits)_bits"
  #calculate the maximum one-hot value.
  #assert that the regimes wire contains the maximum value (missing 0 of course)
  @wire one_hot_regime        (2 * bits - 3):1v

  one_hot_max = (2 * bits - 3)
  #calculating the number of decoded regime bits is tricky.
  decoded_regime_bits = regime_bits(bits)

  result = Wire(decoded_regime_bits)

  for n in range(decoded_regime_bits)
    result[n] = |([one_hot_regime[idx] for idx in 1:one_hot_max if (idx % (1<<(n+1))) >= (1 << n)]...)
    # E.G:
    # result[0] = or([one_hot_regimes[idx] for idx in 1:one_hot_max if (idx % 2) >= 1]...)
    # result[1] = or([one_hot_regimes[idx] for idx in 1:one_hot_max if (idx % 4) >= 2]...)
  end

  result
end

@verilog function set_regime(signinv::Wire{1:0v}, one_hot_shifts::Wire, bits::Integer)
  @name_suffix                  "$(bits)_bits"
  #the one_hot_shifts can only take a limited number of bits in.
  @wire one_hot_shifts      range(bits-1)

  result = Wire(regime_bits(bits))

  #inverted rail lines
  invertedrail = xorxnor(signinv)

  #encode the one-hot regime.
  one_hot_regime   = set_one_hot_regime(invertedrail, one_hot_shifts, bits)
  result           = set_binary_regime(one_hot_regime, bits)

  result
end

function decode_posit(posit::Wire, bits::Integer)
  @wire posit       range(bits)

  #are all but the first bit zero?
  allzeros = nor(posit[(bits-2):0v])

  infzeroflags = set_inf_zero_bits(posit[bits-1], allzeros)

  #the one_hot_shift is a one-hot representation of how far to the left the
  #representation is.  In the case of 8-bit posits, 6 means we're at the far
  #left; 0 means the regime bits go all the way to the end.

  one_hot_shift = set_one_hot_shift(posit[bits-1:0v], bits)

  fraction_bits = set_fraction(posit[(bits-3):0v], one_hot_shift[bits-2:2v])

  regime_bits = set_regime(posit[bits-1:(bits-2)v], one_hot_shift,)

  #set the wire to the expected representation.
  result = Wire(posit[bits-1], regime_bits, fraction_bits)
end
