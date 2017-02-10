/* regimeshifter.v
  inputs an 8-bit posit and returns a 6-bit fraction.*/

module regimeshifter_8bit(
  input [7:0] posit,
  output[4:0] frc);

  wire [5:1] xorlines;
  wire [5:2] xnorlines;
  wire [4:0] shiftselector;

  assign xorlines = (posit[5:1] ^ {5{posit[6]}});
  assign xnorlines = ~(xorlines[5:2]);

  assign shiftselector[4] = xorlines[5];
  assign shiftselector[3] = (xorlines[4] & xnorlines[5]);
  assign shiftselector[2] = &({xorlines[3], xnorlines[5:4]});
  assign shiftselector[1] = &({xorlines[2], xnorlines[5:3]});
  assign shiftselector[0] = &({xorlines[1], xnorlines[5:2]});

  assign frc[4] = |((shiftselector[4:0] & posit[4:0]));
  assign frc[3] = |((shiftselector[4:1] & posit[3:0]));
  assign frc[2] = |((shiftselector[4:2] & posit[2:0]));
  assign frc[1] = |((shiftselector[4:3] & posit[1:0]));
  assign frc[0] = |((shiftselector[4]   & posit[0]));
endmodule
