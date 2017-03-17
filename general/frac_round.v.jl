
#frac_round.v.jl

doc"""
  `frac_round(fraction, gs, bits)`
  rounds the fraction.  fraction should be (bits-3) bits long; gs is a two-bit
  value representing the guard (gs[1]) and summary (gs[0]) bits.
"""
@verilog function frac_round(unrounded_frc::Wire, gs::Wire{1:0v}, bits::Integer, padding = 0)
  @suffix             (padding == 0 ? "$(bits)bit" : "$(bits)p$(padding)bit")
  @input              unrounded_frc        range(bits - 3)

  inner_bit = unrounded_frc[0]

  should_roundup = gs[1] & (gs[0] | inner_bit)
  add_value = Wire(Wire(zero(UInt64), bits-4), should_roundup)

  rounded_frc = Wire(unrounded_frc + add_value, padding * Wire(false))
end
