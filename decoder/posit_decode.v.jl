@verilog function set_inf_zero_bits(
  signbit::SingleWire,
  allzeros::SingleWire)

  result = Wire(allzeros & signbit, allzeros & (~signbit))
end

@verilog function set_one_hot_shift(posit::Wire, bits::Integer)
  @name_suffix        "$(bits)bit"
  #describe the incoming posit wire.
  @wire posit         range(bits)

  xorlines  = posit[(bits-3):0v] ^ ((bits - 2) * posit[bits-2])

  xnorlines = ~xorlines

  result = Wire(bits-1)

  result[0] = xorlines[bits-3]
  for idx = 1:(bits-3)
    result[idx] = and(Wire(xorlines[bits - 3 - idx], xnorlines[bits-3:(bits-2-idx)v]))
  end
  result[bits-2] = and(xnorlines[(bits-3):0v])

  result
end

@verilog function set_fraction(posit::Wire, one_hot_shifts::Wire, bits::Integer)
  #describe the incoming posit wire.
  @name_suffix                  "$(bits)bit"
  @wire posit                   range(bits)
  @wire one_hot_shifts          range(bits-1)

  result = Wire(bits-3)

  for bit in range(bits-3)
    #result[0] = |(one_hot_shifts[0:0] & posit[0:0])
    #result[1] = |(one_hot_shifts[0:1] & posit[1:0])
    result[bit] = |(one_hot_shifts[0:(bit)v] & posit[bit:0v])
  end

  result
end

@verilog function set_one_hot_regime(inverted::Wire{1:0v}, one_hot_shifts::Wire, bits::Integer)
  #inverted[1] is sign xor inv
  #inverted[0] is sign xnor inv
  @name_suffix                  "$(bits)bit"
  @wire one_hot_shifts          range(bits-1)

  #calculate the maximum one-hot value.
  one_hot_max = (2 * bits - 3)
  result = Wire(one_hot_max:1v)

  #in 8-bits, the results looks like as follows:
  # result 1:13
  # result[1] = inverted[0] & one_hot_shift[5]
  # result[2] = inverted[0] & one_hot_shift[4]
  # result[3] = inverted[0] & one_hot_shift[3]
  #  ...
  # result[6] = inverted[0] & one_hot_shift[0]
  # result[7] = inverted[1] & one_hot_shift[0]
  # result[8] = inverted[1] & one_hot_shift[1]
  #  ...
  # result[13] = inverted[1] & one_hot_shift[6]

  # result[6:1] = (6 * inverted[0]) & one_hot_shift[0:5]
  # result[13:7] = (7 * inverted[1]) & one_hot_shift[6:0]

  result[(bits-2):1v]             = ((bits - 2) * inverted[0]) & one_hot_shifts[0:(bits - 3)v]
  result[(one_hot_max):(bits-1)v] = ((bits - 1) * inverted[1]) & one_hot_shifts[(bits-2):0v]

  result
end

@verilog function set_binary_regime(one_hot_regime::Wire, bits::Integer)
  @name_suffix                  "$(bits)bit"
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
  @name_suffix                  "$(bits)bit"
  #the one_hot_shifts can only take a limited number of bits in.
  @wire one_hot_shifts      range(bits-1)

  result = Wire(regime_bits(bits))
  #inverted rail lines.
  invertedrail = xorxnor(signinv)
  #encode the one-hot regime.
  one_hot_regime   = set_one_hot_regime(invertedrail, one_hot_shifts, bits)
  result           = set_binary_regime(one_hot_regime, bits)

  result
end

@verilog function decode_posit(posit::Wire, bits::Integer)
  @name_suffix                  "$(bits)bit"
  @wire posit                   range(bits)

  #are all but the first bit zero?
  allzeros = nor(posit[(bits-2):0v])

  infzeroflags = set_inf_zero_bits(posit[bits-1], allzeros)

  #the one_hot_shift is a one-hot representation of how far to the left the
  #representation is.  In the case of 8-bit posits, 6 means we're at the far
  #left; 0 means the regime bits go all the way to the end.

  one_hot_shift = set_one_hot_shift(posit, bits)

  fraction_bits = set_fraction(posit, one_hot_shift, bits)

  regime_bits = set_regime(posit[(bits-1):(bits-2)v], one_hot_shift, bits)

  #set the wire to the extended posit representation.
  result = Wire(infzeroflags, posit[bits-1], regime_bits, fraction_bits)
end
