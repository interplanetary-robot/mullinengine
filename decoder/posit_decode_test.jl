
#set_inf_zero_bits
@test set_inf_zero_bits(0b0, 0b0) == 0b00 # unless all bits are zero, it's neither inf nor zero.
@test set_inf_zero_bits(0b1, 0b0) == 0b00 #
@test set_inf_zero_bits(0b0, 0b1) == 0b01 # top bit zero => zero
@test set_inf_zero_bits(0b1, 0b1) == 0b10 # top bit one => inf
## all values confirmed using EDA-Testbench (will integrate verilated tests soon)

## test one-hot-shift in 8 bits and 16 bits
function shift(n::Unsigned)
  top_bit = one(n) << (sizeof(n) * 8 - 1)
  zero_choice = n & (-one(n) & (~top_bit))
  one_choice = n | top_bit
  return max(leading_zeros(zero_choice), leading_ones(one_choice)) - 2
end

function ohs(n::Unsigned)
  one(UInt64) << (sizeof(n) * 8 - 2 - shift(n))
end

println("testing onehotshift_8:")
for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
    @test set_one_hot_shift(idx, 8) == ohs(idx)
end end

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
  (n << shift(n)) & (~(UInt64(7) << (sizeof(n) * 8 - 3)))
end

#spot testing the "fraction" routine
@test fraction(0b0101_0111) == (0b1_0111)
@test fraction(0b0111_0110) == (0b1_1000)
@test fraction(0b0001_1010) == (0b1_0100)

for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
  @test set_fraction(idx, ohs(idx) , 8) == fraction(idx)
end end

################################################################################
#test one-hot regime
function invertedduple(n::Unsigned)
  top_bit = one(n) << (sizeof(n) * 8 - 1)
  next_bit = top_bit >> 1
  inv = (top_bit & n != 0) $ (next_bit & n != 0)
  0x2 * !inv + one(UInt64) * inv
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

for idx = 0x01:0xFF if idx != 0x80 #ignore the inf value
  @test set_one_hot_regime(invertedduple(idx), ohs(idx) , 8) == ohe(idx)
end end

################################################################################
# test binary encoding test.
for idx = 0x00:0x0d
  @test set_binary_regime(one(UInt64) << (idx - 1), 8) == idx
end
#also with 16-bits
for idx = 0x00:0x1d
  @test set_binary_regime(one(UInt64) << (idx - 1), 16) == idx
end

################################################################################
