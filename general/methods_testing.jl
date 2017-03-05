#test exp_trim with 8-bit values.  Note that the 8-bit bias value is 7.  The
#untrimmed length of the biased exponent is 4.

#padding one, bit size 8.

#regular old number, positive
@test exp_trim(0b0, 0b01000, 0b11111, 8, 1, :no) == 0b100011111
#regular old number, negative
@test exp_trim(0b1, 0b01000, 0b11111, 8, 1, :no) == 0b100011111
#exceeding exponent, positive
@test exp_trim(0b0, 0b01111, 0b00000, 8, 1, :no) == 0b110111111
#exceeding exponent, negative
@test exp_trim(0b1, 0b01111, 0b11111, 8, 1, :no) == 0b110000000
#overflow border exponents, positive
@test exp_trim(0b0, 0b01110, 0b00000, 8, 1, :no) == 0b110111111
@test exp_trim(0b0, 0b01101, 0b00000, 8, 1, :no) == 0b110100000
@test exp_trim(0b0, 0b01100, 0b00000, 8, 1, :no) == 0b110000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b01101, 0b11111, 8, 1, :no) == 0b110000000
@test exp_trim(0b1, 0b01100, 0b11111, 8, 1, :no) == 0b110011111
@test exp_trim(0b1, 0b01011, 0b11111, 8, 1, :no) == 0b101111111
#underflow border exponents, positive
@test exp_trim(0b0, 0b00010, 0b11111, 8, 1, :no) == 0b001011111
@test exp_trim(0b0, 0b00001, 0b11111, 8, 1, :no) == 0b000111111
@test exp_trim(0b0, 0b00000, 0b11111, 8, 1, :no) == 0b000100000
#overflow border exponents, negative
@test exp_trim(0b1, 0b00001, 0b00000, 8, 1, :no) == 0b000100000
@test exp_trim(0b1, 0b00000, 0b00000, 8, 1, :no) == 0b000000000
#negative exponents, positive
@test exp_trim(0b0, 0b11111, 0b11111, 8, 1, :no) == 0b000100000
#negative exponents, negative
@test exp_trim(0b1, 0b11111, 0b00000, 8, 1, :no) == 0b000011111

#padding two, bit size 8.
#regular old number, positive
@test exp_trim(0b0, 0b001000, 0b11111, 8, 2, :no) == 0b100011111
#regular old number, negative
@test exp_trim(0b1, 0b001000, 0b11111, 8, 2, :no) == 0b100011111
#exceeding exponent, positive
@test exp_trim(0b0, 0b011100, 0b00000, 8, 2, :no) == 0b110111111
#exceeding exponent, negative
@test exp_trim(0b1, 0b011100, 0b11111, 8, 2, :no) == 0b110000000
#overflow border exponents, positive
@test exp_trim(0b0, 0b001110, 0b00000, 8, 2, :no) == 0b110111111
@test exp_trim(0b0, 0b001101, 0b00000, 8, 2, :no) == 0b110100000
@test exp_trim(0b0, 0b001100, 0b00000, 8, 2, :no) == 0b110000000
#overflow border exponents, negative
@test exp_trim(0b1, 0b001101, 0b11111, 8, 2, :no) == 0b110000000
@test exp_trim(0b1, 0b001100, 0b11111, 8, 2, :no) == 0b110011111
@test exp_trim(0b1, 0b001011, 0b11111, 8, 2, :no) == 0b101111111
#underflow border exponents, positive
@test exp_trim(0b0, 0b000010, 0b11111, 8, 2, :no) == 0b001011111
@test exp_trim(0b0, 0b000001, 0b11111, 8, 2, :no) == 0b000111111
@test exp_trim(0b0, 0b000000, 0b11111, 8, 2, :no) == 0b000100000
#overflow border exponents, negative
@test exp_trim(0b1, 0b000001, 0b00000, 8, 2, :no) == 0b000100000
@test exp_trim(0b1, 0b000000, 0b00000, 8, 2, :no) == 0b000000000
#negative exponents, positive
@test exp_trim(0b0, 0b111111, 0b11111, 8, 2, :no) == 0b000100000
#negative exponents, negative
@test exp_trim(0b1, 0b111111, 0b00000, 8, 2, :no) == 0b000011111
