##posit_encode.v.jl  - encoder for posits

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

  println("regime_subtrahend: ", regime_subtrahend)

  #generate the inverted signed regime.
  signed_regime     = regime - regime_subtrahend

  println("signed_regime: ", signed_regime)

  inv_signed_regime = -signed_regime[range(sbits)] - Wire(one(UInt64),sbits)

  println("inv_signed_regime: ", inv_signed_regime)

  #pull the sign of signed regime to determine what to do next.
  regime_sign = signed_regime[sbits]

  println("regime_sign: ", regime_sign)

  #mux the two possibilities, then recombine
  result = Wire(signed_regime[sbits],
    ((sbits * regime_sign) & inv_signed_regime) | ((sbits * (~regime_sign)) & signed_regime[range(sbits)]))
end

doc"""
  one_hot_regime(::Wire{R}, bits::Integer)

  Takes a regime shift and returns a one-hot encoding of the shift.

  in 8-bits:
  0- no shift
  6- shift all the way (and send top fraction bit to the guard)
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

  println("detected sign and inverse: ", Wire(sign, inv))

  leading_bits = xorxnor(Wire(sign, inv))

  #top bit should be xnor, next bit should be xnor
  println("extended fraction top bits:", Wire(leading_bits[0], leading_bits[1]))

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
  #new guard bit: [6:0] [7:1]
  println("--------------------")
  println("guard bit comparator")
  println(one_hot[(bits-2):0v], " & ", ext_frac[bits-1:1v])
  println(one_hot[(bits-2):0v] &  ext_frac[bits-1:1v])
  shifted_frac[1] = |(one_hot[(bits-2):0v] & ext_frac[bits-1:1v])
  println("guard bit: ", shifted_frac[1])
  println("--------------------23,")
  for idx in (bits-1:2v)
    #examples from bits == 8
    #shifted_frac[2] = |({one_hot[5:0] & ext_frac[7:2], |(one_hot[6]) & ext_frac[7]})
    #shifted_frac[3] = |({one_hot[4:0] & ext_frac[7:3], |(one_hot[6:5]) & ext_frac[7]})
    shifted_frac[idx] = |(Wire((one_hot[(bits-idx-1):0v]) & ext_frac[(bits-1):(idx)v], (|(one_hot[(bits-2):(bits-idx)v])) & ext_frac[bits]))
  end
  shifted_frac[bits] = |(one_hot) & ext_frac[8]

  shifted_frac
end

@verilog function encoding_finalizer(inf::SingleWire, zero::SingleWire, sign::SingleWire, shifted_frac::Wire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire shifted_frac              range(bits+1)

  rounded_flag = ((shifted_frac[0] & shifted_frac[1]) | (shifted_frac[1] & shifted_frac[2]))

  println("rounded_flag: ", rounded_flag)

  rounded_value = shifted_frac[bits:2v] + Wire((bits - 2) * Wire(false), rounded_flag)

  println("rounded_value: ", rounded_value)

  provisional_posit = Wire(sign, rounded_value)

  println("provisional_posit: ", provisional_posit)

  infzero = inf | zero

  posit = ((bits * infzero) & Wire(inf, (bits-1) * Wire(false))) | ((bits * ~infzero) & provisional_posit)
end

@verilog function encode_posit(eposit::Wire, guard::SingleWire, summary::SingleWire, bits::Integer)
  @name_suffix "$(bits)bit"
  @wire eposit                    range(bits + regime_bits(bits))

  rbits = regime_bits(bits)
  totalbits = bits + rbits

  println("encoding posit: ", eposit)

  regimeshift = regime_shift(eposit[(totalbits-4):(bits-3)v], bits)

  println("regimeshift: ", regimeshift)

  one_hot = one_hot_regime(regimeshift[(rbits-2):0v], bits)

  println("one_hot: ", one_hot)

  extended_frac = ext_fraction_encoding(eposit[totalbits - 3], regimeshift[rbits - 1], eposit[(bits-4):0v], guard, summary, bits)

  println("extended frac: ", extended_frac)

  shifted_frac = shifted_fraction_encoding(one_hot, extended_frac, bits)

  println("shifted_frac: ", shifted_frac)

  posit = encoding_finalizer(eposit[totalbits - 1], eposit[totalbits - 2], eposit[totalbits - 3], shifted_frac, bits)
end
