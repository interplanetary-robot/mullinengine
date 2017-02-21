##posit_encode.v.jl  - encoder for posits

eposit_size(bits::Integer) = regime_bits(bits) + bits
regime_bias(bits) = (bits - 1)

doc"""
  regime_shift(::Wire{R}, bits::Integer)

  Takes a regime value and returns the "regime shift".  This is how many places
  the exponent/fraction section should be moved.  R should be of size
  log2(bits) + 1; the regime shift is a wire of size log2.  Top bit of the regime
  shift indicates the sign, 1 for negative and 0 for not.
"""
@verilog function regime_shift(regime::Wire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire regime range(regime_bits(bits))

  #calculate and store the bits of the regime.
  rbits = regime_bits(bits)
  sbits = rbits - 1

  regime_subtrahend = Wire(Unsigned(regime_bias(bits)), rbits)

  #generate the inverted signed regime.
  signed_regime     = regime - regime_subtrahend
  inv_signed_regime = -signed_regime[range(sbits)]

  #pull the sign of signed regime to determine what to do next.
  regime_sign = signed_regime[sbits]

  #mux the two possibilities, then recombine
  result = Wire(signed_regime[sbits], (sbits * regime_sign) & inv_signed_regime) | ((sbits * (~regime_sign)) & signed_regime[range(sbits)])
end

function bitof(x, y)
  return ((1 << y) & x) != 0
end

doc"""
  one_hot_regime(::Wire{R}, bits::Integer)

  Takes a regime shift and returns a one-hot encoding of the shift.
"""
@verilog function one_hot_regime(regimeshift::Wire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire regimeshift range(regime_bits(bits) - 1)

  inv_regimeshift = ~regimeshift

  #declare the result wire.
  result = Wire(bits-1)

  for idx in range(bits - 1)
    result[idx] = (&)([(bitof(idx, jdx)) ? regimeshift[jdx] : inv_regimeshift[jdx] for jdx in range(regime_bits(bits) - 1)]...)
  end

  result
end

doc"""
  ext_fraction_encoding(sign::SingleWire, inv::SingleWire, frac::Wire{R}, guard::SingleWire, summary::SingleWire, bits::Integer)

  does a full encoding of the fraction by integrating the inverse unary prefix,
  and any guard & summary bits that are provided.  Results in t
"""
@verilog function ext_fraction_encoding(sign::SingleWire, inv::SingleWire, frac::Wire, guard::SingleWire, summary::SingleWire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire frac range(bits - 3)

  leading_bits = xorxnor(sign, inv)

  ext_fraction = Wire(leading_bits[0], leading_bits[1], frac, guard, summary)
end

doc"""
  shifted_fraction_encoding(sign, one_hot, extended_fraction, (bits))
  creates a process that encodes the the basic parts of the posit from the
  one_hot shift index and the extended fraction data.  Result is basically the
  entire posit with the guard and summary bits grafted on the tail end (for a
  total size of (bits + 1))
"""
@verilog function shifted_fraction_encoding(one_hot::Wire, ext_frac::Wire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire one_hot  range(bits - 1)
  @wire ext_frac range(bits + 1)

  #the guard bit and the summary bit have different dynamics.
  shifted_frac = Wire(bits + 1)

  #accumulate informatin for the summary bits
  summary_accumulator = Wire(bits-1)
  for idx in range(bits-1)
    summary_accumulator[idx] = one_hot[idx] & (|)(ext_frac[idx:0v])
  end

  shifted_frac[0] = |(summary_accumulator)
  shifted_frac[1] = |(one_hot[(bits-2):0v] & ext_frac[bits-1:1v])
  for idx in (bits-1:2v)
    #examples from bits == 8
    #shifted_frac[2] = |({one_hot[5:0] & ext_frac[7:2], |(one_hot[6]) & ext_frac[8]})
    #shifted_frac[3] = |({one_hot[4:0] & ext_frac[7:3], |(one_hot[6:5]) & ext_frac[8]})
    shifted_frac[idx] = |(Wire((one_hot[(bits-idx-1):0v]) & ext_frac[(bits-1):(idx)v], (|(one_hot[(bits-2):(bits-idx)v])) & ext_frac[bits]))
  end
  shifted_frac[bits] = |(one_hot) & ext_frac[8]

  shifted_frac
end
