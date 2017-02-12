// full posit decoder module.

module set_inf_zero_bits(
  input  signbit,
  input  allzeros,
  output [1:0]result);

  assign result[1] = allzeros & signbit;
  assign result[0] = allzeros & !signbit;
endmodule

module set_shiftlines_8bit(
  input  [6:0]posit,
  output [6:0]result);

  wire [5:0] xorlines;
  wire [5:0] xnorlines;

  //xorlines calculate if the regime bits are consistent with the inversion bit.
  assign xorlines = (posit[5:0] ^ {6{posit[6]}});
  //xnorlines calculate if we've previously seen a bit inconsistent with the inversion bit.
  assign xnorlines = ~(xorlines[5:0]);

  assign result[6] = xorlines[5];
  assign result[5] = (xorlines[4] & xnorlines[5]);
  assign result[4] = &({xorlines[3], xnorlines[5:4]});
  assign result[3] = &({xorlines[2], xnorlines[5:3]});
  assign result[2] = &({xorlines[1], xnorlines[5:2]});
  assign result[1]  = &({xorlines[0], xnorlines[5:1]});
  assign result[0]  = &(xnorlines[5:0]);
endmodule

module set_fraction_8bit(
  input [4:0] posit,
  input [4:0] shiftquant, //4-actual shift amount.
  output[4:0] result);

  //assign the fraction bits
  assign result[4] = |((shiftquant[4:0] & posit[4:0]));
  assign result[3] = |((shiftquant[4:1] & posit[3:0]));
  assign result[2] = |((shiftquant[4:2] & posit[2:0]));
  assign result[1] = |((shiftquant[4:3] & posit[1:0]));
  assign result[0] = |((shiftquant[4]   & posit[0]));
endmodule

module set_semantic_exp_8bit(
  input [1:0]  inverted,
  input [6:0]  shiftlines,
  output[13:1] result);

  assign result[6:1] = {6{inverted[1]}} & shiftlines[6:1];
  //assign these wires in reverse.
  assign result[7]  = inverted[0] & shiftlines[6];
  assign result[8]  = inverted[0] & shiftlines[5];
  assign result[9]  = inverted[0] & shiftlines[4];
  assign result[10] = inverted[0] & shiftlines[3];
  assign result[11] = inverted[0] & shiftlines[2];
  assign result[12] = inverted[0] & shiftlines[1];
  assign result[13] = inverted[0] & shiftlines[0];

endmodule

module set_binary_exp_8bit(
  input [13:1] sem,
  output[3:0] result);

  //it seems bad to be doing this by hand.
  assign result[0] = |{sem[1], sem[3], sem[5],  sem[7],  sem[9],  sem[11], sem[13]};
  assign result[1] = |{sem[2], sem[3], sem[6],  sem[7],  sem[10], sem[11]};
  assign result[2] = |{sem[4], sem[5], sem[6],  sem[7],  sem[12], sem[13]};
  assign result[3] = |{sem[8], sem[9], sem[10], sem[11], sem[12], sem[13]};
endmodule

module set_exponent_8bit(
  input [1:0] signinv,
  input [6:0] shiftlines,
  output [3:0] result);

  //create the inverted rail wires.
  wire [1:0] invertedrail;
  assign invertedrail[0] = ^(signinv);
  assign invertedrail[1] = !invertedrail[0];

  //a one-hot encoding of the semantic exponent meaning.
  wire [13:1] semantic_exponent;
  set_semantic_exp_8bit set_se(
    .inverted   (invertedrail),
    .shiftlines (shiftlines),
    .result     (semantic_exponent));

  set_binary_exp_8bit set_be(
    .sem        (semantic_exponent),
    .result     (result));

endmodule


//posit_decode_8bit takes an 8-bit posit and breaks it down into a 12-bit
//datatype.  This 12-bit datatype consists of the following information:
// MSB                                    LSB
// |  11 | 10  |  9  | 8        5 | 4      0 |
// | INF | ZER | SGN | BIASED_EXP | FRACTION |
module posit_decode_8bit(
  input [7:0]  posit,
  output[11:0] dposit);

  //the allzeros wire will check if the last seven bits are zero, triggering
  //inf or zero.
  wire allzeros;
  assign allzeros = ~|(posit[6:0]);

  //a module that calculates the inf and zero flags.  This will be lazily calculated.
  set_inf_zero_bits set_iz(
    .signbit    (posit[7]),
    .allzeros   (allzeros),
    .result     (dposit[11:10]));

  //the shiftvaluelines are a one-hot representation of how far to the left the
  //representation is.  In the case of 8-bit posits, 6 means we're at the far
  //left; 0 means the regime bits go all the way to the end.
  wire [6:0] shiftlines;

  set_shiftlines_8bit set_sl(
    .posit      (posit[6:0]),
    .result     (shiftlines));

  set_fraction_8bit set_frac(
    .posit      (posit[4:0]),
    .shiftquant (shiftlines[6:2]),
    .result     (dposit[4:0]));

  //this is the trickiest part of the decode.  Takes the posit and
  set_exponent_8bit set_exp(
    .signinv       (posit[7:6]),
    .shiftlines    (shiftlines),
    .result        (dposit[8:5]));

  //set other results.  The sign bit is set from the posit value.
  assign dposit[9] = posit[7];

endmodule
