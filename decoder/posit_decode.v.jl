@verilog function dec_inf_zero_bits(
  signbit::SingleWire,
  allzeros::SingleWire)

  result = Wire(allzeros & signbit, allzeros & (~signbit))
end

doc"""
  dec_shift_onehot(posit::Wire, bits)

  decodes the shift value.  This uses a 'rolling xor' where the value is checked
  for difference with the previous value; and any other deltas ahead of it
  disqualifies the value.

  posit should have [bits] bits
  and the result, shift_onehot should have [bits - 2]bits.
"""
@verilog function dec_shift_onehot(posit::Wire, bits::Integer)
  @suffix             "$(bits)bit"
  #describe the incoming posit wire.
  @input posit         range(bits)

  #xorlines and xnorlines define a set of rails that are a comparison of the
  #value with the next-to-msb bit ("invert bit") and the bit referred to.
  xorlines  = posit[(msb-2):0v] ^ ((bits - 2) * posit[msb-1])
  xnorlines = ~xorlines

  #declare the size of shift_onehot
  shift_onehot = Wire(bits-1)

  #notice the pattern.  Compare the previous to the last, and collate all
  #previous results (xnorlines), disqualifying if one exists.
  shift_onehot[0] = xorlines[msb]
  for idx = 1:(bits-3)
    shift_onehot[idx] = and(Wire(xorlines[msb - idx], xnorlines[msb:(msb-(idx-1))v]))
  end
  shift_onehot[msb] = and(xnorlines[msb:0v])

  shift_onehot
end

doc"""
  dec_expfrac(posit::Wire, shift_onehot::Wire, bits)

  decodes the "expfrac" part of the posit, based on the posit binary value
  and the shift, encoded in one-hot format.

  posit should have bits wires and shift_onehot should have bits-1 wires;
  the result will be a wire of length bits-3 which is a left-shifted fraction.
"""
@verilog function dec_expfrac(posit::Wire, shift_onehot::Wire, bits::Integer)
  #describe the incoming posit wire.
  @suffix                       "$(bits)bit"
  @input posit                   range(bits)
  @input shift_onehot            range(bits-1)

  expfrac = Wire(bits-3)

  for bit in range(bits-3)
    #result[0] = |(one_hot_shifts[0:0] & posit[0:0])
    #result[1] = |(one_hot_shifts[0:1] & posit[1:0])
    expfrac[bit] = |(shift_onehot[0:(bit)v] & posit[bit:0v])
  end

  expfrac
end

doc"""
  dec_regime_onehot(inv_rails::Wire{1:0v}, shift_onehot::Wire, bits)

  takes a shift value, as a onehot encoding and converts it to a onehot encoded
  regime value, based on a inverted rail indicator.  If the value is inverted,
  inv_rails should be 2\'10; if the value is not inverted then inv_rails should
  be 2\'01.

  shift_onehot should have bits-2 wires.
"""
@verilog function dec_regime_onehot(inv_rails::Wire{1:0v}, shift_onehot::Wire, bits::Integer)
  @suffix                       "$(bits)bit"
  @input shift_onehot            range(bits-1)

  #inv_rails[1] is sign xor inv  - aka "inverted"
  #inv_rails[0] is sign xnor inv - aka "uninverted"

  #calculate the maximum one-hot value.
  regime_onehot = Wire((2 * bits - 3):1v)

  #in 8-bits, the results looks like as follows:
  # result 1:13
  # result[1] = inv_rails[0] & shift_onehot[5]
  # result[2] = inv_rails[0] & shift_onehot[4]
  # result[3] = inv_rails[0] & shift_onehot[3]
  #  ...
  # result[6] = inv_rails[0] & shift_onehot[0]
  # result[7] = inv_rails[1] & shift_onehot[0]
  # result[8] = inv_rails[1] & shift_onehot[1]
  #  ...
  # result[13] = inv_rails[1] & shift_onehot[6]

  # result[6:1]  = (6 * inv_rails[0]) & shift_onehot[0:5]
  # result[13:7] = (7 * inv_rails[1]) & shift_onehot[6:0]

  regime_onehot[(bits-2):1v]     = ((bits - 2) * inv_rails[0]) & shift_onehot[0:(msb-1)v]
  regime_onehot[msb:(bits-1)v]   = ((bits - 1) * inv_rails[1]) & shift_onehot[msb:0v]

  regime_onehot
end

doc"""
  dec_regime_binary(signinv::Wire{1:0v}, shift_onehot::Wire, bits)

  takes a regime encoded in one-hot encoding and converts it to a binary encoding.
  a regime should be able to take values from 0:(2 * bits - 3).  Input should have
  (2 * bits - 3) lines, starting from ONE (zero regime remains unencoded).  Output
  should have ⌈log2(bits)⌉ + 1 bits (usually log2(bits) + 1).
"""
@verilog function dec_regime_bin(one_hot_regime::Wire, bits::Integer)
  @suffix                     "$(bits)bit"
  #calculate the maximum one-hot value.
  #assert that the regimes wire contains the maximum value (missing 0 of course)
  @input one_hot_regime        (2 * bits - 3):1v

  one_hot_max = (2 * bits - 3)
  #calculating the number of decoded regime bits is tricky.
  decoded_regime_bits = regime_bits(bits)

  regime_bin = Wire(decoded_regime_bits)

  for n in range(decoded_regime_bits)
    regime_bin[n] = |([one_hot_regime[idx] for idx in 1:one_hot_max if (idx % (1<<(n+1))) >= (1 << n)]...)
    # E.G:
    # result[0] = or([one_hot_regimes[idx] for idx in 1:one_hot_max if (idx % 2) >= 1]...)
    # result[1] = or([one_hot_regimes[idx] for idx in 1:one_hot_max if (idx % 4) >= 2]...)
  end

  regime_bin
end

doc"""
  dec_regime(signinv::Wire{1:0v}, shift_onehot::Wire, bits)

  decodes a biased regime value based on the one-hot-shift value and a "signinv"
  value which are the 'sign' and 'inverse' bits from the front end of the original
  posit.
"""
@verilog function dec_regime(signinv::Wire{1:0v}, shift_onehot::Wire, bits::Integer)
  @suffix                       "$(bits)bit"
  @input shift_onehot            range(bits-1)
  #------------------------------------------

  regime = Wire(regime_bits(bits))

  #rails (a pair of lines which are opposite of each other) which represent the
  #inverted state of the value.  This is ascertained by checking the xor state
  #of

  inv_rails = xorxnor(signinv)

  #the dec_regime function passes the hard work over to two helper
  #functions.  dec_regime_onehot takes the onehot shifts and ascertains the
  #encodes as a onehot regime value.  dec_regime_bin then takes the onehot
  #encoded regimes and turns them into the equivalent binary representation.
  regime_onehot    = dec_regime_onehot(inv_rails, shift_onehot, bits)
  regime           = dec_regime_bin(regime_onehot, bits)

  regime
end

doc"""
  decode_posit(posit::Wire, bits)

  converts a [bits]bit posit and outputs the corresponding "expanded" posit.
  The expanded posit has the following form:

  | inf_bit | zer_bit | sgn_bit | MSB  ...regime... LSB | MSB ...exp/frac... LSB |
  |  1 bit  |  1 bit  |  1 bit  |  log2(bits) + 1 bits  |     (bits - 3) bits    |

  note that the exp/frac section contains the exponent/fraction bits.  If ES == 0
  the regime is exactly equal to the exponent.

  If ES != 0, then the exponent is `{regime << ES, expfrac[msb:(msb-ES)]}`
  and the fraction is `expfrac[(msb-ES-1):0]`

  output is labeled "eposit".
"""
@verilog function decode_posit(posit::Wire, bits::Integer)
  @suffix                       "$(bits)bit"
  @input posit                   range(bits)
  #---------------------------------------

  #are all but the first bit zero?
  allzeros = nor(posit[(msb-1):0v])

  infzeroflags = dec_inf_zero_bits(posit[msb], allzeros)

  #the one_hot_shift is a one-hot representation of how far we must move the
  #values.  This value is used both in extracting the relevant fraction bits
  #and is used to calculate the regime, so we have to set this wire early.
  shift_onehot = dec_shift_onehot(posit, bits)

  #pull the expfrac bits from the posit structure.
  expfrac_bits = dec_expfrac(posit, shift_onehot, bits)

  #pull the regime bits out of the posit structure.
  regime_bits = dec_regime(posit[msb:(msb-1)v], shift_onehot, bits)

  #set the wire to the extended posit representation.
  eposit = Wire(infzeroflags, posit[msb], regime_bits, expfrac_bits)
end

#TODO:  update this so that decode_posit emits a different structure.
