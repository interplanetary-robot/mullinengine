##posit_encode.v.jl  - encoder for posits

doc"""
  enc_shift_bin(::Wire{R}, bits::Integer)

  Takes a regime value and returns the "regime shift".  This is how many places
  the exponent/fraction section should be moved.  R should be of size
  log2(bits) + 1; the regime shift is a wire of size log2.  Top bit of the regime
  shift indicates the sign, 1 for negative and 0 for not.
"""
@verilog function enc_shift_bin(regime::Wire, bits::Integer)
  @suffix                         "$(bits)bit"
  @wire regime                    range(regime_bits(bits))

  #calculate and store the bits of the regime.
  rbits = regime_bits(bits)
  sbits = rbits - 1

  regime_subtrahend = Wire(Unsigned(regime_bias(bits)), rbits)

  #generate the inverted signed regime.
  signed_regime     = regime - regime_subtrahend

  inv_signed_regime = -signed_regime[range(sbits)] - Wire(one(UInt64),sbits)

  #pull the sign of signed regime to determine what to do next.
  regime_sign = signed_regime[sbits]

  #mux the two possibilities, then recombine
  shift_bin = Wire(signed_regime[sbits],
    ((sbits * regime_sign) & inv_signed_regime) | ((sbits * (~regime_sign)) & signed_regime[range(sbits)]))
end

doc"""
  enc_regime_onehot(::Wire{R}, bits::Integer)

  Takes a regime shift and returns a one-hot encoding of the shift.

  in 8-bits:
  0- no shift
  6- shift all the way (and send top fraction bit to the guard)
"""
@verilog function enc_regime_onehot(shift_bin::Wire, bits::Integer)
  @suffix                           "$(bits)bit"
  @wire shift_bin                   range(regime_bits(bits) - 1)

  neg_shift_bin = ~shift_bin

  #declare the result wire.
  regime_onehot = Wire(bits-1)

  for idx in range(bits - 1)
    regime_onehot[idx] = (&)([(bitof(idx, jdx)) ? shift_bin[jdx] : neg_shift_bin[jdx] for jdx in range(regime_bits(bits) - 1)]...)
  end

  regime_onehot
end

doc"""
  ext_fraction_encoding(sign::SingleWire, inv::SingleWire, frac::Wire{R}, guard::SingleWire, summary::SingleWire, bits::Integer)

  does a full encoding of the fraction by integrating the inverse unary prefix,
  and any guard & summary bits that are provided.

  efrac_gs format:

  | inv_bit | !inv_bit | MSB  ...left-shifted fraction...  LSB | guard | summary |
  |  1 bit  |  1 bit   |        (bits - 3) bits                | 1 bit |  1 bit  |

"""
@verilog function enc_efrac_gs(sign::SingleWire, inv::SingleWire, frac::Wire, guard::SingleWire, summary::SingleWire, bits::Integer)
  @suffix                           "$(bits)bit"
  @wire frac                        range(bits - 3)

  leading_bits = xorxnor(Wire(sign, inv))

  efrac_gs = Wire(leading_bits[0], leading_bits[1], frac, guard, summary)
end

doc"""
  enc_shifted_frac(sign, one_hot, extended_fraction, (bits))
  creates a process that encodes the the basic parts of the posit from the
  one_hot shift index and the extended fraction data.

  shifted_frac_gs format:

  | MSB  ...posit[msb-1:0]...  LSB | guard | summary |
  |        (bits - 1) bits         | 1 bit |  1 bit  |

"""
@verilog function enc_shifted_frac_gs(one_hot::Wire, ext_frac::Wire, bits::Integer)
  @suffix                          "$(bits)bit"
  @wire one_hot                    range(bits - 1)
  @wire ext_frac                   range(bits + 1)

  #the guard bit and the summary bit have different dynamics.
  shifted_frac = Wire(bits + 1)

  #accumulate informatin for the summary bits
  summary_accumulator = Wire(bits-1)
  for idx in range(bits-1)
    summary_accumulator[idx] = one_hot[idx] & (|)(ext_frac[idx:0v])
  end

  shifted_frac[0] = |(summary_accumulator)
  #new guard bit: [6:0] [7:1]
  shifted_frac[1] = |(one_hot[msb:0v] & ext_frac[(msb-1):1v])
  for idx in (bits-1:2v)
    #examples from bits == 8
    #shifted_frac[2] = |({one_hot[5:0] & ext_frac[7:2], |(one_hot[6]) & ext_frac[8]})
    #shifted_frac[3] = |({one_hot[4:0] & ext_frac[7:3], |(one_hot[6:5]) & ext_frac[8]})
    shifted_frac[idx] = |(Wire((one_hot[(msb-(idx-1)):0v]) & ext_frac[(msb-1):(idx)v], (|(one_hot[msb:(bits-idx)v])) & ext_frac[msb]))
  end
  shifted_frac[bits] = |(one_hot) & ext_frac[msb]

  shifted_frac
end

doc"""
  enc_finalizer(inf::SingleWire, zero::SingleWire, sign::SingleWire, shifted_frac::Wire, bits)

  finalizes the process of encoding the posit.  This takes the shifted
  frac/guard/summary, analyses it and performs RTNE, augmenting if necessary,
  then also checks if the inf or zero flags are thrown, which results in nuking
  the entire result and replacing with canonical infinity and zero values.

  shifted_frac_gs should be the shifted fraction which contains the entire posit
  payload except for the sign bit, and with a guard/summary bit appended on the
  end.

  NB:  error checking should occur here, but it is not currently implemented.
"""
@verilog function enc_finalizer(inf::SingleWire, zero::SingleWire, sign::SingleWire, shifted_frac_gs::Wire, bits::Integer)
  @suffix                         "$(bits)bit"
  @wire shifted_frac_gs           range(bits+1)

  rounded_flag = ((shifted_frac_gs[0] & shifted_frac_gs[1]) | (shifted_frac_gs[1] & shifted_frac_gs[2]))

  rounded_value = shifted_frac_gs[bits:2v] + Wire((bits - 2) * Wire(false), rounded_flag)

  provisional_posit = Wire(sign, rounded_value)

  infzero = inf | zero

  #assign the posit, by cancelling the result if we have an infinity or zero
  #value or otherwise keeping it.
  posit = ((bits * infzero) & Wire(inf, (bits-1) * Wire(false))) | ((bits * ~infzero) & provisional_posit)
end

doc"""
  encode_posit(eposit::Wire, guard::SingleWire, summary::SingleWire, bits)

  converts an extended posit (plus extra information) into a rounded posit
  in the canonical form.

  extended posit format:

  | inf_bit | zer_bit | sgn_bit | MSB  ...regime... LSB | MSB ...exp/frac... LSB |
  |  1 bit  |  1 bit  |  1 bit  |  log2(bits) + 1 bits  |     (bits - 3) bits    |

  the guard bit should be a value which represents what the next "bit" should be;
  the summary bit should be a value which represents |((lsb+2):∞); aka if ANY
  of the following bits are theoretically nonzero

  NB:  Future versions of this may implement alternative rounding modes.  Future
  versions may also allow you to omit "guard" and "summary" bits as "optionalwires"
  which will result in simpler wiring for specific applications.
"""
@verilog function encode_posit(eposit::Wire, guard::SingleWire, summary::SingleWire, bits::Integer)
  @suffix                         "$(bits)bit"
  @wire eposit                    range(bits + regime_bits(bits))

  rbits = regime_bits(bits)
  totalbits = bits + rbits

  shift_bin = enc_shift_bin(eposit[(totalbits-4):(bits-3)v], bits)

  regime_onehot = enc_regime_onehot(shift_bin[(rbits-2):0v], bits)

  efrac_gs = enc_efrac_gs(eposit[totalbits - 3], shift_bin[rbits - 1], eposit[(bits-4):0v], guard, summary, bits)

  shifted_frac_gs = enc_shifted_frac_gs(regime_onehot, efrac_gs, bits)

  posit = enc_finalizer(eposit[totalbits - 1], eposit[totalbits - 2], eposit[totalbits - 3], shifted_frac_gs, bits)
end
