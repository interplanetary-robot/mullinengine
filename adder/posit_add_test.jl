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
@test add_apply_shift(0b10111010, 0b000_0001, 8) == 0b00011101
@test add_apply_shift(0b01011100, 0b000_0010, 8) == 0b00011100
@test add_apply_shift(0b00101110, 0b000_0100, 8) == 0b00011100
@test add_apply_shift(0b00010110, 0b000_1000, 8) == 0b00011000
@test add_apply_shift(0b00001010, 0b001_0000, 8) == 0b00010000
@test add_apply_shift(0b00000100, 0b010_0000, 8) == 0b00000000
@test add_apply_shift(0b00000010, 0b100_0000, 8) == 0b00000000

#test reinterpreting one-hot shifts as deltas
@test add_shift_diff(0b000_0001, 8) == 0b00001
@test add_shift_diff(0b000_0010, 8) == 0b00000
@test add_shift_diff(0b000_0100, 8) == 0b11111
@test add_shift_diff(0b000_1000, 8) == 0b11110
@test add_shift_diff(0b001_0000, 8) == 0b11101
@test add_shift_diff(0b010_0000, 8) == 0b11100
@test add_shift_diff(0b100_0000, 8) == 0b11011

#test the actual adding procedure
@test add_theoretical(0b0111, 0b01_11111, 0b0111, 0b01_00000, 8) == 0b1_0111_010_11111
@test add_theoretical(0b0111, 0b01_11111, 0b0111, 0b01_00001, 8) == 0b1_0111_011_00000

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
