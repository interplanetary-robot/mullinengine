//note: for the ouput.  Last 5 lines are the fraction bits, first four are the
//exponent bits.
module regimeshifter_with_exp_8bit(
  input [7:0] posit,
  output[8:0] eposit);

  wire [5:0] xorlines;
  wire [5:0] xnorlines;
  wire [4:0] shiftselector;
  wire [1:0] terminalline;
  wire [12:1] explut;

  assign xorlines = (posit[5:0] ^ {6{posit[6]}});
  assign xnorlines = ~(xorlines[5:0]);

  assign shiftselector[4] = xorlines[5];
  assign shiftselector[3] = (xorlines[4] & xnorlines[5]);
  assign shiftselector[2] = &({xorlines[3], xnorlines[5:4]});
  assign shiftselector[1] = &({xorlines[2], xnorlines[5:3]});
  assign shiftselector[0] = &({xorlines[1], xnorlines[5:2]});
  assign terminalline[0]  = &({xorlines[0], xnorlines[5:1]});
  assign terminalline[1]  = &(xnorlines[5:0]);

  //assign the fraction bits

  assign eposit[4] = |((shiftselector[4:0] & posit[4:0]));
  assign eposit[3] = |((shiftselector[4:1] & posit[3:0]));
  assign eposit[2] = |((shiftselector[4:2] & posit[2:0]));
  assign eposit[1] = |((shiftselector[4:3] & posit[1:0]));
  assign eposit[0] = |((shiftselector[4]   & posit[0]));

  //now, let's work on the exponent lookup table.

  assign explut[5:1]  = ({5{!posit[6]}} & shiftselector[4:0]);
  assign explut[12:6] = {7{posit[6]}} & {terminalline[0], terminalline[1],
                                         shiftselector[0], shiftselector[1],
                                         shiftselector[2], shiftselector[3],
                                         shiftselector[4]};

  //create the actual lookups.
  assign eposit[5] = |{explut[1], explut[3], explut[5], explut[7], explut[9], explut[11]};
  assign eposit[6] = |{explut[2], explut[3], explut[6], explut[7], explut[10], explut[11]};
  assign eposit[7] = |{explut[4], explut[5], explut[6], explut[7], explut[12]};
  assign eposit[8] = |{explut[8], explut[9], explut[10], explut[11], explut[12]};
endmodule
