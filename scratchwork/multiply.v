//performs a basic fraction multiplication with the implicit bit exposed.
module fracmult_8bit(
  input [4:0] left_frac,
  input [4:0] right_frac,
  output [11:0] result);

  assign result[11:0] = {1'b1, left_frac} * {1'b1, right_frac};
endmodule


module multiply_8bit(
  input clk,
  input [7:0] leftposit,
  input [7:0] rightposit,
  output reg [18:0] result);//18: sign | 17-13: exponent | 12-0: fraction

  wire [9:0] left_unpacked;
  wire [9:0] right_unpacked;
  wire [11:0] result_frac;

  unpackposit_8bit leftunpack(
    .posit  (leftposit),
    .uposit (left_unpacked));

  unpackposit_8bit rightunpack(
    .posit  (rightposit),
    .uposit (right_unpacked));

  fracmult_8bit fracmult(
    .left_frac (left_unpacked[4:0]),
    .right_frac(right_unpacked[4:0]),
    .result    (result_frac));

  initial begin
    result[18:0] = 18'h0000;
  end

  always @(posedge clk) begin
    result[18]       <= left_unpacked[9] ^ right_unpacked[9];
    // set the exponent.  increment if the multiplication carried.
    result[17:13]    <= left_unpacked[8:5] + right_unpacked[8:5] + 2 + result_frac[11];
    if (result_frac[11])
      result[12:3]   <= result_frac[10:1];
    else
      result[12:3]   <= result_frac[9:0];
    end
    result[2:0]      <= 3'b000;
  end
endmodule
