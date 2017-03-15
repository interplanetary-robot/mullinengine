#test add_shift_onehot - calculates the correct onehot shift indicators for
#the representation.
@test add_shift_onehot(0b0, 0b100000000, 8) == 0b000_0001
@test add_shift_onehot(0b0, 0b101110100, 8) == 0b000_0001
@test add_shift_onehot(0b0, 0b010111000, 8) == 0b000_0010
@test add_shift_onehot(0b0, 0b001011100, 8) == 0b000_0100
@test add_shift_onehot(0b0, 0b000101100, 8) == 0b000_1000
@test add_shift_onehot(0b0, 0b000010100, 8) == 0b001_0000
@test add_shift_onehot(0b0, 0b000001000, 8) == 0b010_0000
@test add_shift_onehot(0b0, 0b000000100, 8) == 0b100_0000

#test applying a one-hot shift
@test add_apply_shift(0b101110100, 0b000_0001, 8) == 0b000111010
@test add_apply_shift(0b010111000, 0b000_0010, 8) == 0b000111000
@test add_apply_shift(0b001011100, 0b000_0100, 8) == 0b000111000
@test add_apply_shift(0b000101100, 0b000_1000, 8) == 0b000110000
@test add_apply_shift(0b000010100, 0b001_0000, 8) == 0b000100000
@test add_apply_shift(0b000001000, 0b010_0000, 8) == 0b000000000
@test add_apply_shift(0b000000100, 0b100_0000, 8) == 0b000000000

#test reinterpreting one-hot shifts as deltas
@test add_shift_diff(0b000_0001, 8) == 0b00001
@test add_shift_diff(0b000_0010, 8) == 0b00000
@test add_shift_diff(0b000_0100, 8) == 0b11111
@test add_shift_diff(0b000_1000, 8) == 0b11110
@test add_shift_diff(0b001_0000, 8) == 0b11101
@test add_shift_diff(0b010_0000, 8) == 0b11100
@test add_shift_diff(0b100_0000, 8) == 0b11011

#test shifting fractional values
@test add_rightshift(0b010_0001_0, 0b0000, 8) == 0b010_0001_00
@test add_rightshift(0b010_0001_0, 0b0001, 8) == 0b001_0000_10
@test add_rightshift(0b010_0001_0, 0b0010, 8) == 0b000_1000_01
@test add_rightshift(0b010_0001_0, 0b0011, 8) == 0b000_0100_01
@test add_rightshift(0b010_0001_0, 0b0100, 8) == 0b000_0010_01
@test add_rightshift(0b010_0001_0, 0b0101, 8) == 0b000_0001_01
@test add_rightshift(0b010_0001_0, 0b0110, 8) == 0b000_0000_11
@test add_rightshift(0b010_0001_0, 0b0111, 8) == 0b000_0000_01
@test add_rightshift(0b010_0001_0, 0b1000, 8) == 0b000_0000_01
@test add_rightshift(0b010_0001_0, 0b1001, 8) == 0b000_0000_01
@test add_rightshift(0b010_0001_0, 0b1010, 8) == 0b000_0000_01

#test applying shifts:
@test add_apply_shift(0b01_10000_00, 0b0000010, 8) == 0b10000_00

#test the actual adding procedure
@test add_theoretical(0b0111, 0b01_11111, 0b0111, 0b01_00000, 8, 0) == 0b1_0111_010_111110
@test add_theoretical(0b0111, 0b01_11111, 0b0111, 0b01_00001, 8, 0) == 0b1_0111_011_000000

function test_8bit_add()
  print("testing 8 bit add...")
  for lhs = 0b0:0xFF
    for rhs = 0b0:0xFF
      lhsp = Posit{8,0}(lhs)
      rhsp = Posit{8,0}(rhs)
      try
        sump = lhsp + rhsp

        sumb = reinterpret(UInt64, sump) >> 56

        @test (sumb, lhs, rhs) == (posit_adder(lhs, rhs, 8), lhs, rhs)
      catch e
        #skip over NaNs.
        if isa(e,SigmoidNumbers.NaNError)
          continue
        end
        rethrow()
      end

    end
  end
  println("OK!")
end
