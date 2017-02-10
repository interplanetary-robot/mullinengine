module unpackposit_8bit(
  input  [7:0] posit,
  output [9:0] uposit);

  wire [7:0] absposit;
  wire [8:0] eposit;

  abs_8bit absval(
    .posit	(posit),
    .result (absposit));

  regimeshifter_with_exp_8bit rshift(
    .posit (absposit),
    .eposit (eposit));

  assign uposit[8:0] = eposit[8:0];
  assign uposit[9] = posit[7];
endmodule
