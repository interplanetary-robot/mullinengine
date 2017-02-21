module set_inf_zero_bits(
  input signbit,
  input allzeros,
  output [1:0] result);

  assign result = {(allzeros & signbit),(allzeros & ~(signbit))};

endmodule

module set_one_hot_shift_8_bit(
  input [7:0] posit,
  output [6:0] result);

  wire [5:0] xnorlines;
  wire [5:0] xorlines;

  assign xorlines = (posit[5:0] ^ {6{posit[6]}});
  assign xnorlines = ~(xorlines);
  assign result [0] = &(xnorlines[5:0]);
  assign result [1] = &({xorlines[0],xnorlines[5:1]});
  assign result [2] = &({xorlines[1],xnorlines[5:2]});
  assign result [3] = &({xorlines[2],xnorlines[5:3]});
  assign result [4] = &({xorlines[3],xnorlines[5:4]});
  assign result [5] = &({xorlines[4],xnorlines[5:5]});
  assign result [6] = xorlines[5];

endmodule

module set_fraction_8_bits(
  input [7:0] posit,
  input [6:0] one_hot_shifts,
  output [4:0] result);

  assign result [0] = |((one_hot_shifts[6:6] & posit[0:0]));
  assign result [1] = |((one_hot_shifts[6:5] & posit[1:0]));
  assign result [2] = |((one_hot_shifts[6:4] & posit[2:0]));
  assign result [3] = |((one_hot_shifts[6:3] & posit[3:0]));
  assign result [4] = |((one_hot_shifts[6:2] & posit[4:0]));

endmodule

module set_one_hot_regime_8_bits(
  input [1:0] inverted,
  input [6:0] one_hot_shifts,
  output [13:1] result);

  assign result [6:1] = ({6{inverted[1]}} & one_hot_shifts[6:1]);
  assign result [13:7] = ({7{inverted[0]}} & {one_hot_shifts[6], one_hot_shifts[5], one_hot_shifts[4], one_hot_shifts[3], one_hot_shifts[2], one_hot_shifts[1], one_hot_shifts[0]});

endmodule

module set_binary_regime_8_bits(
  input [13:1] one_hot_regime,
  output [3:0] result);

  assign result [0] = |({one_hot_regime[1], one_hot_regime[3], one_hot_regime[5], one_hot_regime[7], one_hot_regime[9], one_hot_regime[11], one_hot_regime[13]});
  assign result [1] = |({one_hot_regime[2], one_hot_regime[3], one_hot_regime[6], one_hot_regime[7], one_hot_regime[10], one_hot_regime[11]});
  assign result [2] = |({one_hot_regime[4], one_hot_regime[5], one_hot_regime[6], one_hot_regime[7], one_hot_regime[12], one_hot_regime[13]});
  assign result [3] = |({one_hot_regime[8], one_hot_regime[9], one_hot_regime[10], one_hot_regime[11], one_hot_regime[12], one_hot_regime[13]});

endmodule

module set_regime_8_bits(
  input [1:0] signinv,
  input [6:0] one_hot_shifts,
  output [3:0] result);

  wire [13:1] one_hot_regime;
  wire [1:0] invertedrail;

  set_one_hot_regime_8_bits set_one_hot_regime_8_bits_one_hot_regime(
    .inverted (invertedrail),
    .one_hot_shifts (one_hot_shifts),
    .result (one_hot_regime));

  set_binary_regime_8_bits set_binary_regime_8_bits_result(
    .one_hot_regime (one_hot_regime),
    .result (result));

  assign invertedrail = {^(signinv), ~^(signinv)};

endmodule

module decode_posit_8_bits(
  input [7:0] posit,
  output [11:0] result);

  wire [6:0] one_hot_shift;
  wire allzeros;
  wire [4:0] fraction_bits;
  wire [1:0] infzeroflags;
  wire [3:0] regime_bits;

  set_inf_zero_bits set_inf_zero_bits_infzeroflags(
    .signbit (posit[7]),
    .allzeros (allzeros),
    .result (infzeroflags));

  set_one_hot_shift_8_bit set_one_hot_shift_8_bit_one_hot_shift(
    .posit (posit),
    .result (one_hot_shift));

  set_fraction_8_bits set_fraction_8_bits_fraction_bits(
    .posit (posit),
    .one_hot_shifts (one_hot_shift),
    .result (fraction_bits));

  set_regime_8_bits set_regime_8_bits_regime_bits(
    .signinv (posit[7:6]),
    .one_hot_shifts (one_hot_shift),
    .result (regime_bits));

  assign allzeros = ~(|(posit[6:0]));
  assign result = {infzeroflags,posit[7],regime_bits,fraction_bits};

endmodule
