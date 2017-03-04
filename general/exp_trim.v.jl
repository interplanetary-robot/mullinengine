#exp_trim.v.jl - implements trimming of expanded values

doc"""
  exp_trim(sign::SingleWire, exp_untrimmed::Wire, frc_untrimmed::Wire)

  takes a (potentially negative) untrimmed exponent value.  This value should be
  padded with at least 1 bit.  The result will be a fused exp-frac value that
  is appropriately trimmed down.  You should set "pad" to be a value that makes
  sense relative to how many bits you expect the exponent to be able to achieve,
  plus one, so that negative representations can be easily distinguished from
  positive representations.

  Rules of thumb:  Pad will be 2 for multiplication (because the maximum product
  will be twice the maximum exponent, which saturates the exponent bits).  Pad
  will be 1 for addition (because the maximum sum will be one more than the
  maximum exponent, which less than 2^bits-1).
"""
@verilog function exp_trim(sign::SingleWire, exp_untrimmed::Wire, frc_untrimmed::Wire, bits::Integer, pad::Integer)
  @assert pad >= 1
  @assert ispow2(bits)

  @suffix               "$(bits)bit_$(pad)pad"
  @input exp_untrimmed  range(regime_bits(bits) + pad)
  @input frc_untrimmed  range(bits - 3)

  #create some invariant values.
  upper_limit_value = max_biased_exp(bits)
  expbits = regime_bits(bits)

  #store these as "constant wires" (for now.  When we have ES, then these will
  #not necessarily be constant anymore).
  positive_limit_exp = Wire(upper_limit_value, expbits + pad)
  negative_limit_exp = Wire(upper_limit_value - 1, expbits + pad)

  #check to see if we have a value that's too low.  Underflow is triggered if
  #the biased exponent is negative (msb[exp_untrimmed])  It can also be triggered
  #if the biased exponent is zero and the sign is positive.
  underflowed = exp_untrimmed[msb] | (~sign & (~|(exp_untrimmed)))

  #check to see if we have a value that's too high.  Firstly, the top bit has to
  #be zero, so that we know it's not negative.  Then, compare against the stored
  #wire constants depending on the sign.
  overflowed = ((~exp_untrimmed[msb]) & (~sign) & (exp_untrimmed > positive_limit_exp)) |
               ((~exp_untrimmed[msb]) & (sign)  & (exp_untrimmed > negative_limit_exp))

  #create a wire constant which is the clipping value.
  clipping_value = Wire(expbits)
  #fill the top bits with either the top bits of upper_limit_value or zeros.
  clipping_value[msb:1v] = Wire(upper_limit_value >> 1, expbits - 1) & ((expbits - 1) * overflowed)
  clipping_value[0] = ~sign

  #the exponent should be clipped if either overflow or underflow has happened.
  do_exp_clipping = underflowed | overflowed

  #nuke the exponent and replace with the clipping value, if relevant.
  exp_trimmed = exp_untrimmed[range(expbits)] & ((expbits) * ~do_exp_clipping) |
                clipping_value                & ((expbits) * do_exp_clipping)

  #What to do with the fraction?  If we're underflowing, set to zero IF it's
  #positive.  set to one, if it's negative.  If we're overflowing, set to ones
  #if it's positive, otherwise set to zeros.

  #for set to zero:
  # overflowed  underflowed   sign   result
  #     T            T         T       D
  #     T            T         F       D
  #     T            F         T       F
  #     T            F         F       T
  #     F            T         T       T
  #     F            T         F       F
  #     F            F         T       T
  #     F            F         F       T
  #boolean formula:  ~(o | u) | (o ^ s)

  #for set to one:
  # overflowed  underflowed   sign   result
  #     T            T         T       D
  #     T            T         F       D
  #     T            F         T       F
  #     T            F         F       T
  #     F            T         T       T
  #     F            T         F       F
  #     F            F         T       F
  #     F            F         F       F
  #boolean formula:  (o | u) & (o ^ s)

  frc_trimmed = (frc_untrimmed[range(bits-3)] &
                  ((bits-3) * (~(overflowed | underflowed) | (overflowed ^ sign)))) |
                  ((bits-3) * ( (overflowed | underflowed) & (overflowed ^ sign)))

  expfrac = Wire(exp_trimmed, frc_trimmed)
end
