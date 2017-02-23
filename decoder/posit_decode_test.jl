
#set_inf_zero_bits

print("testing inf_zero_bits...")
@test set_inf_zero_bits(0b0, 0b0) == 0b00 # unless all bits are zero, it's neither inf nor zero.
@test set_inf_zero_bits(0b1, 0b0) == 0b00 #
@test set_inf_zero_bits(0b0, 0b1) == 0b01 # top bit zero => zero
@test set_inf_zero_bits(0b1, 0b1) == 0b10 # top bit one => inf
println("OK!")
## all values confirmed using EDA-Testbench (will integrate verilated tests soon)

## test one-hot-shift in 8 bits and 16 bits
function shift(n::Unsigned)
  top_bit = one(n) << (sizeof(n) * 8 - 1)
  zero_choice = n & (-one(n) & (~top_bit))
  one_choice = n | top_bit
  return max(leading_zeros(zero_choice), leading_ones(one_choice)) - 2
end

@test shift(0b0110_0000) == 1
@test shift(0b0100_0000) == 0
@test shift(0b0010_0000) == 0
@test shift(0b1110_0000) == 1
@test shift(0b1100_0000) == 0
@test shift(0b1010_0000) == 0

function ohs(n::Unsigned)
  one(UInt64) << shift(n)
end

@test ohs(0b0111_1111) == 1 << 6
@test ohs(0b0111_1000) == 1 << 3
@test ohs(0b0111_0000) == 1 << 2
@test ohs(0b0110_0000) == 1 << 1
@test ohs(0b0100_0000) == 1 << 0
@test ohs(0b0010_0000) == 1 << 0
@test ohs(0b0001_0000) == 1 << 1
@test ohs(0b0000_1000) == 1 << 2
@test ohs(0b1111_1111) == 1 << 6
@test ohs(0b1110_0000) == 1 << 1
@test ohs(0b1100_0000) == 1 << 0
@test ohs(0b1010_0000) == 1 << 0
@test ohs(0b1001_0000) == 1 << 1
@test ohs(0b1000_1000) == 1 << 2
@test ohs(0b1000_0100) == 1 << 3

print("testing onehotshift_8...")
for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
    @test (set_one_hot_shift(idx, 8), idx) == (ohs(idx), idx)
end end
println("OK!")

#16-bit testing (slow!)
#=
println("testing onehotshift_16:")

for idx = 1:(2^16 - 1) if idx != 0x8000 #ignore the inf value.
    @test set_one_hot_shift(UInt16(idx), 16) == ohs(UInt16(idx))
end end
=#

################################################################################
#test fraction elucidation.

function fraction(n::Unsigned)
  (n << shift(n)) & ((one(UInt64) << (sizeof(n) * 8 - 3)) - one(UInt64))
end

#spot testing the "fraction" routine
@test fraction(0b0101_0111) == (0b1_0111)
@test fraction(0b0111_0110) == (0b1_1000)
@test fraction(0b0001_1010) == (0b1_0100)

for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
  @test (set_fraction(idx, ohs(idx) , 8), idx) == (fraction(idx), idx)
end end

################################################################################
#test one-hot regime
function invertedduple(n::Unsigned)
  top_bit = one(n) << (sizeof(n) * 8 - 1)
  next_bit = top_bit >> 1
  inv = (top_bit & n != 0) $ (next_bit & n != 0)
  0x2 * inv + one(UInt64) * !inv
end

function ohe(n::Unsigned)
  top_bit = one(n) << (sizeof(n) * 8 - 1)
  next_bit = top_bit >> 1
  negative = ((top_bit & n) != 0)
  invertq = ((next_bit & n) != 0)
  uninverted = negative $ invertq
  1 << ((sizeof(n) * 8) - 2 + (uninverted ? shift(n) : (-shift(n)-1)))
end

#verify that this works as expected.
@test ohe(0b0111_1111) == 1 << 12 #one hot regime is 13.
@test ohe(0b0110_0000) == 1 << 7
@test ohe(0b0100_0000) == 1 << 6  #one-hot regime of 1 is 7.
@test ohe(0b0010_0000) == 1 << 5
@test ohe(0b0000_0001) == 1
@test ohe(0b1111_1111) == 0
@test ohe(0b1100_1000) == 1 << 5
@test ohe(0b1100_0000) == 1 << 5
@test ohe(0b1011_1111) == 1 << 6
@test ohe(0b1000_0001) == 1 << 11

print("testing one_hot_regime...")
for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
  @test set_one_hot_regime(invertedduple(idx), ohs(idx) , 8) == ohe(idx)
end end
println("OK")

################################################################################
# test binary encoding test.
for idx = 0x00:0x0d
  @test set_binary_regime(one(UInt64) << (idx - 1), 8) == idx
end
#also with 16-bits
for idx = 0x00:0x1d
  @test set_binary_regime(one(UInt64) << (idx - 1), 16) == idx
end
#=
#not to be actually implemented.
@verilog function regime_checker(posit::Wire{7:0v})
  invertedrail = xorxnor(posit[7:6v])

  one_hot_shift = set_one_hot_shift(posit, 8)
  result = set_regime(invertedrail, one_hot_shift, 8)
end
=#

################################################################################
# test setting regimes

function decoded_posit_8(n::Unsigned)
  (n == 0b1000_0000) && return 0b1_0_1_1101_00000
  (n == 0b0000_0000) && return 0b0_1_0_0000_00000
  fracpart = (n << shift(n)) & 0x1F
  #next calculate the exponential regime
  top_bit = one(UInt64) << (sizeof(n) * 8 - 1)
  next_bit = top_bit >> 1
  negative = ((top_bit & n) != 0)
  invertq = ((next_bit & n) != 0)
  uninverted = negative $ invertq
  exponent = (sizeof(n) * 8) - 1 + (uninverted ? shift(n) : (-shift(n)-1))

  ((top_bit & n) << 2) | exponent << 5 | fracpart
end

#test to make sure our function is accurate.
@test decoded_posit_8(0b1000_0000) == 0b1_0_1_1101_00000
@test decoded_posit_8(0b0000_0000) == 0b0_1_0_0000_00000

@test decoded_posit_8(0b0111_1111) == 0b0_0_0_1101_00000
@test decoded_posit_8(0b0100_0000) == 0b0_0_0_0111_00000
@test decoded_posit_8(0b0000_0001) == 0b0_0_0_0001_00000
@test decoded_posit_8(0b1111_1111) == 0b0_0_1_0000_00000
@test decoded_posit_8(0b1100_0000) == 0b0_0_1_0110_00000
@test decoded_posit_8(0b1000_0001) == 0b0_0_1_1100_00000

@test decoded_posit_8(0b0101_0110) == 0b0_0_0_0111_10110
@test decoded_posit_8(0b0111_0110) == 0b0_0_0_1001_11000
@test decoded_posit_8(0b0001_0110) == 0b0_0_0_0101_01100
@test decoded_posit_8(0b1101_0110) == 0b0_0_1_0110_10110
@test decoded_posit_8(0b1111_0110) == 0b0_0_1_0100_11000
@test decoded_posit_8(0b1001_0110) == 0b0_0_1_1000_01100

print("testing full posit decode...")
for idx = 0x00:0xFF
  @test (decoded_posit_8(idx), idx) == (decode_posit(idx, 8), idx)
end
println("OK")
