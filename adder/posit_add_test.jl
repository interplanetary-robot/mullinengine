#test add_shift_onehot - calculates the correct onehot shift indicators for
#the representation.

@test add_shift_onehot(0b0, 0b1011101, 8) == 0b000_0001
@test add_shift_onehot(0b0, 0b0101110, 8) == 0b000_0010
@test add_shift_onehot(0b0, 0b0010111, 8) == 0b000_0100
@test add_shift_onehot(0b0, 0b0001011, 8) == 0b000_1000
@test add_shift_onehot(0b0, 0b0000101, 8) == 0b001_0000
@test add_shift_onehot(0b0, 0b0000010, 8) == 0b010_0000
@test add_shift_onehot(0b0, 0b0000001, 8) == 0b100_0000

#test applying a one-hot shift
@test add_apply_shift(0b1011101, 0b000_0001, 8) == 0b0001110
@test add_apply_shift(0b0101110, 0b000_0010, 8) == 0b0001110
@test add_apply_shift(0b0010111, 0b000_0100, 8) == 0b0001110
@test add_apply_shift(0b0001011, 0b000_1000, 8) == 0b0001100
@test add_apply_shift(0b0000101, 0b001_0000, 8) == 0b0001000
@test add_apply_shift(0b0000010, 0b010_0000, 8) == 0b0000000
@test add_apply_shift(0b0000001, 0b100_0000, 8) == 0b0000000

#test reinterpreting one-hot shifts as deltas
@test add_shift_diff(0b000_0001, 8) == 0b00001
@test add_shift_diff(0b000_0010, 8) == 0b00000
@test add_shift_diff(0b000_0100, 8) == 0b11111
@test add_shift_diff(0b000_1000, 8) == 0b11110
@test add_shift_diff(0b001_0000, 8) == 0b11101
@test add_shift_diff(0b010_0000, 8) == 0b11100
@test add_shift_diff(0b100_0000, 8) == 0b11011
