#test exp_trim with 8-bit values.  Note that the 8-bit bias value is 7.  The
#untrimmed length of the biased exponent is 4.

#padding one, add mode.

#regular old number, positive
@test exp_trim(0b0, 0b01000, 0b1111111, 8, :add) == 0b10001111111
#regular old number, negative
@test exp_trim(0b1, 0b01000, 0b1111111, 8, :add) == 0b10001111111
#exceeding exponent, positive
@test exp_trim(0b0, 0b01111, 0b0000000, 8, :add) == 0b11011111111
#exceeding exponent, negative
@test exp_trim(0b1, 0b01111, 0b1111111, 8, :add) == 0b11000000000
#overflow border exponents, positive
@test exp_trim(0b0, 0b01110, 0b0000000, 8, :add) == 0b11011111111
@test exp_trim(0b0, 0b01101, 0b0000000, 8, :add) == 0b11010000000
@test exp_trim(0b0, 0b01100, 0b0000000, 8, :add) == 0b11000000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b01101, 0b1111111, 8, :add) == 0b11000000000
@test exp_trim(0b1, 0b01100, 0b1111111, 8, :add) == 0b11001111111
@test exp_trim(0b1, 0b01011, 0b1111111, 8, :add) == 0b10111111111
#underflow border exponents, positive
@test exp_trim(0b0, 0b00010, 0b1111111, 8, :add) == 0b00101111111
@test exp_trim(0b0, 0b00001, 0b1111111, 8, :add) == 0b00011111111
@test exp_trim(0b0, 0b00000, 0b1111111, 8, :add) == 0b00010000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b00001, 0b0000000, 8, :add) == 0b00010000000
@test exp_trim(0b1, 0b00000, 0b0000000, 8, :add) == 0b00000000000
#negative exponents, positive
@test exp_trim(0b0, 0b11111, 0b1111111, 8, :add) == 0b00010000000
#negative exponents, negative
@test exp_trim(0b1, 0b11111, 0b0000000, 8, :add) == 0b00001111111

#padding two, mul mode.
#regular old number, positive
@test exp_trim(0b0, 0b001000, 0b1111111, 8, :mul) == 0b10001111111
#regular old number, negative
@test exp_trim(0b1, 0b001000, 0b1111111, 8, :mul) == 0b10001111111
#exceeding exponent, positive
@test exp_trim(0b0, 0b011100, 0b0000000, 8, :mul) == 0b11011111111
#exceeding exponent, negative
@test exp_trim(0b1, 0b011100, 0b1111111, 8, :mul) == 0b11000000000
#overflow border exponents, positive
@test exp_trim(0b0, 0b001110, 0b0000000, 8, :mul) == 0b11011111111
@test exp_trim(0b0, 0b001101, 0b0000000, 8, :mul) == 0b11010000000
@test exp_trim(0b0, 0b001100, 0b0000000, 8, :mul) == 0b11000000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b001101, 0b1111111, 8, :mul) == 0b11000000000
@test exp_trim(0b1, 0b001100, 0b1111111, 8, :mul) == 0b11001111111
@test exp_trim(0b1, 0b001011, 0b1111111, 8, :mul) == 0b10111111111
#underflow border exponents, positive
@test exp_trim(0b0, 0b000010, 0b1111111, 8, :mul) == 0b00101111111
@test exp_trim(0b0, 0b000001, 0b1111111, 8, :mul) == 0b00011111111
@test exp_trim(0b0, 0b000000, 0b1111111, 8, :mul) == 0b00010000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b000001, 0b0000000, 8, :mul) == 0b00010000000
@test exp_trim(0b1, 0b000000, 0b0000000, 8, :mul) == 0b00000000000
#negative exponents, positive
@test exp_trim(0b0, 0b111111, 0b1111111, 8, :mul) == 0b00010000000
#negative exponents, negative
@test exp_trim(0b1, 0b111111, 0b0000000, 8, :mul) == 0b00001111111
