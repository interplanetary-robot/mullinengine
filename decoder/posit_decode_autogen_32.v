module set_inf_zero_bits(
  input signbit,
  input allzeros,
  output [1:0] result);

  assign result = {(allzeros & signbit),(allzeros & ~(signbit))};

endmodule

module set_one_hot_shift_32_bit(
  input [31:0] posit,
  output [30:0] result);

  wire [29:0] xnorlines;
  wire [29:0] xorlines;

  assign xorlines = (posit[29:0] ^ {30{posit[30]}});
  assign xnorlines = ~(xorlines);
  assign result [0] = &(xnorlines[29:0]);
  assign result [1] = &({xorlines[0],xnorlines[29:1]});
  assign result [2] = &({xorlines[1],xnorlines[29:2]});
  assign result [3] = &({xorlines[2],xnorlines[29:3]});
  assign result [4] = &({xorlines[3],xnorlines[29:4]});
  assign result [5] = &({xorlines[4],xnorlines[29:5]});
  assign result [6] = &({xorlines[5],xnorlines[29:6]});
  assign result [7] = &({xorlines[6],xnorlines[29:7]});
  assign result [8] = &({xorlines[7],xnorlines[29:8]});
  assign result [9] = &({xorlines[8],xnorlines[29:9]});
  assign result [10] = &({xorlines[9],xnorlines[29:10]});
  assign result [11] = &({xorlines[10],xnorlines[29:11]});
  assign result [12] = &({xorlines[11],xnorlines[29:12]});
  assign result [13] = &({xorlines[12],xnorlines[29:13]});
  assign result [14] = &({xorlines[13],xnorlines[29:14]});
  assign result [15] = &({xorlines[14],xnorlines[29:15]});
  assign result [16] = &({xorlines[15],xnorlines[29:16]});
  assign result [17] = &({xorlines[16],xnorlines[29:17]});
  assign result [18] = &({xorlines[17],xnorlines[29:18]});
  assign result [19] = &({xorlines[18],xnorlines[29:19]});
  assign result [20] = &({xorlines[19],xnorlines[29:20]});
  assign result [21] = &({xorlines[20],xnorlines[29:21]});
  assign result [22] = &({xorlines[21],xnorlines[29:22]});
  assign result [23] = &({xorlines[22],xnorlines[29:23]});
  assign result [24] = &({xorlines[23],xnorlines[29:24]});
  assign result [25] = &({xorlines[24],xnorlines[29:25]});
  assign result [26] = &({xorlines[25],xnorlines[29:26]});
  assign result [27] = &({xorlines[26],xnorlines[29:27]});
  assign result [28] = &({xorlines[27],xnorlines[29:28]});
  assign result [29] = &({xorlines[28],xnorlines[29:29]});
  assign result [30] = xorlines[29];

endmodule

module set_fraction_32_bits(
  input [31:0] posit,
  input [30:0] one_hot_shifts,
  output [28:0] result);

  assign result [0] = |((one_hot_shifts[30:30] & posit[0:0]));
  assign result [1] = |((one_hot_shifts[30:29] & posit[1:0]));
  assign result [2] = |((one_hot_shifts[30:28] & posit[2:0]));
  assign result [3] = |((one_hot_shifts[30:27] & posit[3:0]));
  assign result [4] = |((one_hot_shifts[30:26] & posit[4:0]));
  assign result [5] = |((one_hot_shifts[30:25] & posit[5:0]));
  assign result [6] = |((one_hot_shifts[30:24] & posit[6:0]));
  assign result [7] = |((one_hot_shifts[30:23] & posit[7:0]));
  assign result [8] = |((one_hot_shifts[30:22] & posit[8:0]));
  assign result [9] = |((one_hot_shifts[30:21] & posit[9:0]));
  assign result [10] = |((one_hot_shifts[30:20] & posit[10:0]));
  assign result [11] = |((one_hot_shifts[30:19] & posit[11:0]));
  assign result [12] = |((one_hot_shifts[30:18] & posit[12:0]));
  assign result [13] = |((one_hot_shifts[30:17] & posit[13:0]));
  assign result [14] = |((one_hot_shifts[30:16] & posit[14:0]));
  assign result [15] = |((one_hot_shifts[30:15] & posit[15:0]));
  assign result [16] = |((one_hot_shifts[30:14] & posit[16:0]));
  assign result [17] = |((one_hot_shifts[30:13] & posit[17:0]));
  assign result [18] = |((one_hot_shifts[30:12] & posit[18:0]));
  assign result [19] = |((one_hot_shifts[30:11] & posit[19:0]));
  assign result [20] = |((one_hot_shifts[30:10] & posit[20:0]));
  assign result [21] = |((one_hot_shifts[30:9] & posit[21:0]));
  assign result [22] = |((one_hot_shifts[30:8] & posit[22:0]));
  assign result [23] = |((one_hot_shifts[30:7] & posit[23:0]));
  assign result [24] = |((one_hot_shifts[30:6] & posit[24:0]));
  assign result [25] = |((one_hot_shifts[30:5] & posit[25:0]));
  assign result [26] = |((one_hot_shifts[30:4] & posit[26:0]));
  assign result [27] = |((one_hot_shifts[30:3] & posit[27:0]));
  assign result [28] = |((one_hot_shifts[30:2] & posit[28:0]));

endmodule

module set_one_hot_regime_32_bits(
  input [1:0] inverted,
  input [30:0] one_hot_shifts,
  output [61:1] result);

  assign result [30:1] = ({30{inverted[1]}} & one_hot_shifts[30:1]);
  assign result [61:31] = ({31{inverted[0]}} & {one_hot_shifts[30], one_hot_shifts[29], one_hot_shifts[28], one_hot_shifts[27], one_hot_shifts[26], one_hot_shifts[25], one_hot_shifts[24], one_hot_shifts[23], one_hot_shifts[22], one_hot_shifts[21], one_hot_shifts[20], one_hot_shifts[19], one_hot_shifts[18], one_hot_shifts[17], one_hot_shifts[16], one_hot_shifts[15], one_hot_shifts[14], one_hot_shifts[13], one_hot_shifts[12], one_hot_shifts[11], one_hot_shifts[10], one_hot_shifts[9], one_hot_shifts[8], one_hot_shifts[7], one_hot_shifts[6], one_hot_shifts[5], one_hot_shifts[4], one_hot_shifts[3], one_hot_shifts[2], one_hot_shifts[1], one_hot_shifts[0]});

endmodule

module set_binary_regime_32_bits(
  input [61:1] one_hot_regime,
  output [5:0] result);

  assign result [0] = |({one_hot_regime[1], one_hot_regime[3], one_hot_regime[5], one_hot_regime[7], one_hot_regime[9], one_hot_regime[11], one_hot_regime[13], one_hot_regime[15], one_hot_regime[17], one_hot_regime[19], one_hot_regime[21], one_hot_regime[23], one_hot_regime[25], one_hot_regime[27], one_hot_regime[29], one_hot_regime[31], one_hot_regime[33], one_hot_regime[35], one_hot_regime[37], one_hot_regime[39], one_hot_regime[41], one_hot_regime[43], one_hot_regime[45], one_hot_regime[47], one_hot_regime[49], one_hot_regime[51], one_hot_regime[53], one_hot_regime[55], one_hot_regime[57], one_hot_regime[59], one_hot_regime[61]});
  assign result [1] = |({one_hot_regime[2], one_hot_regime[3], one_hot_regime[6], one_hot_regime[7], one_hot_regime[10], one_hot_regime[11], one_hot_regime[14], one_hot_regime[15], one_hot_regime[18], one_hot_regime[19], one_hot_regime[22], one_hot_regime[23], one_hot_regime[26], one_hot_regime[27], one_hot_regime[30], one_hot_regime[31], one_hot_regime[34], one_hot_regime[35], one_hot_regime[38], one_hot_regime[39], one_hot_regime[42], one_hot_regime[43], one_hot_regime[46], one_hot_regime[47], one_hot_regime[50], one_hot_regime[51], one_hot_regime[54], one_hot_regime[55], one_hot_regime[58], one_hot_regime[59]});
  assign result [2] = |({one_hot_regime[4], one_hot_regime[5], one_hot_regime[6], one_hot_regime[7], one_hot_regime[12], one_hot_regime[13], one_hot_regime[14], one_hot_regime[15], one_hot_regime[20], one_hot_regime[21], one_hot_regime[22], one_hot_regime[23], one_hot_regime[28], one_hot_regime[29], one_hot_regime[30], one_hot_regime[31], one_hot_regime[36], one_hot_regime[37], one_hot_regime[38], one_hot_regime[39], one_hot_regime[44], one_hot_regime[45], one_hot_regime[46], one_hot_regime[47], one_hot_regime[52], one_hot_regime[53], one_hot_regime[54], one_hot_regime[55], one_hot_regime[60], one_hot_regime[61]});
  assign result [3] = |({one_hot_regime[8], one_hot_regime[9], one_hot_regime[10], one_hot_regime[11], one_hot_regime[12], one_hot_regime[13], one_hot_regime[14], one_hot_regime[15], one_hot_regime[24], one_hot_regime[25], one_hot_regime[26], one_hot_regime[27], one_hot_regime[28], one_hot_regime[29], one_hot_regime[30], one_hot_regime[31], one_hot_regime[40], one_hot_regime[41], one_hot_regime[42], one_hot_regime[43], one_hot_regime[44], one_hot_regime[45], one_hot_regime[46], one_hot_regime[47], one_hot_regime[56], one_hot_regime[57], one_hot_regime[58], one_hot_regime[59], one_hot_regime[60], one_hot_regime[61]});
  assign result [4] = |({one_hot_regime[16], one_hot_regime[17], one_hot_regime[18], one_hot_regime[19], one_hot_regime[20], one_hot_regime[21], one_hot_regime[22], one_hot_regime[23], one_hot_regime[24], one_hot_regime[25], one_hot_regime[26], one_hot_regime[27], one_hot_regime[28], one_hot_regime[29], one_hot_regime[30], one_hot_regime[31], one_hot_regime[48], one_hot_regime[49], one_hot_regime[50], one_hot_regime[51], one_hot_regime[52], one_hot_regime[53], one_hot_regime[54], one_hot_regime[55], one_hot_regime[56], one_hot_regime[57], one_hot_regime[58], one_hot_regime[59], one_hot_regime[60], one_hot_regime[61]});
  assign result [5] = |({one_hot_regime[32], one_hot_regime[33], one_hot_regime[34], one_hot_regime[35], one_hot_regime[36], one_hot_regime[37], one_hot_regime[38], one_hot_regime[39], one_hot_regime[40], one_hot_regime[41], one_hot_regime[42], one_hot_regime[43], one_hot_regime[44], one_hot_regime[45], one_hot_regime[46], one_hot_regime[47], one_hot_regime[48], one_hot_regime[49], one_hot_regime[50], one_hot_regime[51], one_hot_regime[52], one_hot_regime[53], one_hot_regime[54], one_hot_regime[55], one_hot_regime[56], one_hot_regime[57], one_hot_regime[58], one_hot_regime[59], one_hot_regime[60], one_hot_regime[61]});

endmodule

module set_regime_32_bits(
  input [1:0] signinv,
  input [30:0] one_hot_shifts,
  output [5:0] result);

  wire [61:1] one_hot_regime;
  wire [1:0] invertedrail;

  set_one_hot_regime_32_bits set_one_hot_regime_32_bits_one_hot_regime(
    .inverted (invertedrail),
    .one_hot_shifts (one_hot_shifts),
    .result (one_hot_regime));

  set_binary_regime_32_bits set_binary_regime_32_bits_result(
    .one_hot_regime (one_hot_regime),
    .result (result));

  assign invertedrail = {^(signinv), ~^(signinv)};

endmodule

module decode_posit_32_bits(
  input [31:0] posit,
  output [37:0] result);

  wire [30:0] one_hot_shift;
  wire allzeros;
  wire [28:0] fraction_bits;
  wire [1:0] infzeroflags;
  wire [5:0] regime_bits;

  set_inf_zero_bits set_inf_zero_bits_infzeroflags(
    .signbit (posit[31]),
    .allzeros (allzeros),
    .result (infzeroflags));

  set_one_hot_shift_32_bit set_one_hot_shift_32_bit_one_hot_shift(
    .posit (posit),
    .result (one_hot_shift));

  set_fraction_32_bits set_fraction_32_bits_fraction_bits(
    .posit (posit),
    .one_hot_shifts (one_hot_shift),
    .result (fraction_bits));

  set_regime_32_bits set_regime_32_bits_regime_bits(
    .signinv (posit[31:30]),
    .one_hot_shifts (one_hot_shift),
    .result (regime_bits));

  assign allzeros = ~(|(posit[30:0]));
  assign result = {infzeroflags,posit[31],regime_bits,fraction_bits};

endmodule
