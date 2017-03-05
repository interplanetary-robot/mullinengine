#posit_mult_test.jl
#testing procedures for posit_mult

################################################################################
#test mul_frac_hidden_crossmultiplier

function crossmultiplier(is_neg::Bool, frac::Unsigned, bits::Integer)
  mask = 1 << (bits-1) - 1

  if (is_neg)
    return (-(frac << 1)) & mask
  else
    return (frac) & mask
  end
end

#do this for 8 bits.
stop_value = (0b1 << 5) - 0b1
print("testing crossmultiplier...")
for idx = 0b0:stop_value
  @test mul_frac_hidden_crossmultiplier(0b0, idx, 8) == crossmultiplier(false, idx, 8)
end
for idx = 0b0:stop_value
  @test mul_frac_hidden_crossmultiplier(0b1, idx, 8) == crossmultiplier(true, idx, 8)
end
println("OK.")

################################################################################
# test mul_frac_finisher

#first, fraction result in 8-bits that doesn't result in a fraction augmentation
@test mul_frac_finisher(0b0, 0b01_11011_00000, 8) == 0b00_11011_000000
#a fraction result in 8-bits (positive) that does result in a fraction augmentation
@test mul_frac_finisher(0b0, 0b10_11011_00000, 8) == 0b01_01101_100000
#a fraction result in 8-bits (positive) that results in a fraction augentation with a pushed value
@test mul_frac_finisher(0b0, 0b11_00010_00000, 8) == 0b01_10001_000000

#negative results

################################################################################
# test mul_frac

#positive x positive, no carry.
@test mul_frac(0b0, 0b01000, 0b0, 0b01000, 8) == 0b00_10010_000000
#positive x positive, simple carry.
@test mul_frac(0b0, 0b10000, 0b0, 0b10000, 8) == 0b01_00100_000000
#positive x positive, carry with bit shift.
@test mul_frac(0b0, 0b11000, 0b0, 0b11000, 8) == 0b01_10001_000000
#positive x positive, lhs power of 2.
@test mul_frac(0b0, 0b00000, 0b0, 0b11011, 8) == 0b00_11011_000000
#positive x positive, rhs power of 2.
@test mul_frac(0b0, 0b10110, 0b0, 0b00000, 8) == 0b00_10110_000000
#positive x positive, both power of 2.
@test mul_frac(0b0, 0b00000, 0b0, 0b00000, 8) == 0b00_00000_000000

#positive x negative, no carry.
@test mul_frac(0b0, 0b01000, 0b1, 0b11000, 8) == 0b00_01110_000000
#positive x negative, simple carry.
@test mul_frac(0b0, 0b10000, 0b1, 0b10000, 8) == 0b01_11100_000000
#positive x negative, carry with bit shift.
@test mul_frac(0b0, 0b11000, 0b1, 0b01000, 8) == 0b01_01111_000000
#positive x negative, lhs power of 2.
@test mul_frac(0b0, 0b00000, 0b1, 0b11011, 8) == 0b00_11011_000000
#positive x negative, rhs power of 2.
@test mul_frac(0b0, 0b10110, 0b1, 0b00000, 8) == 0b01_01010_000000
#positive x negative, both power of 2.
@test mul_frac(0b0, 0b00000, 0b1, 0b00000, 8) == 0b00_00000_000000

#negative x negative, no carry.
@test mul_frac(0b1, 0b11000, 0b1, 0b11000, 8) == 0b00_10010_000000
#negative x negative, carry with bit shift.
@test mul_frac(0b1, 0b10000, 0b1, 0b10000, 8) == 0b01_00100_000000
#negative x negative, carry with bit shift.
@test mul_frac(0b1, 0b01000, 0b1, 0b01000, 8) == 0b01_10001_000000
#negative x negative, lhs power of 2.
@test mul_frac(0b1, 0b00000, 0b1, 0b11011, 8) == 0b01_00101_000000
#negative x negative, rhs power of 2.
@test mul_frac(0b1, 0b10110, 0b1, 0b00000, 8) == 0b01_01010_000000
#negative x negative, both power of 2.
@test mul_frac(0b1, 0b00000, 0b1, 0b00000, 8) == 0b10_00000_000000

#do the actual multiplication testing.

using SigmoidNumbers

function test_8bit_mul()
  print("testing 8 bit mul...")
  for lhs = 0b0:0xFF
    for rhs = 0b0:0xFF
      lhsp = Posit{8,0}(lhs)
      rhsp = Posit{8,0}(rhs)
      try
        prodp = lhsp * rhsp

        prodb = reinterpret(UInt64, prodp) >> 56

        @test (prodb, lhs, rhs) == (posit_multiplier(lhs, rhs, 8, 8), lhs, rhs)
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

function test_16bit_mul()
  print("testing 16 bit mul...")
  for lhs = 0x0000:0xFFFF
    for rhs = 0x0000:0xFFFF
      lhsp = Posit{16,0}(lhs)
      rhsp = Posit{16,0}(rhs)
      try
        prodp = lhsp * rhsp

        prodb = reinterpret(UInt64, prodp) >> 48

        @test (prodb, lhs, rhs) == (posit_multiplier(lhs, rhs, 16, 16), lhs, rhs)
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
