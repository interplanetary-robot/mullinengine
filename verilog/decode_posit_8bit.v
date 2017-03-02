/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSED */


module dec_inf_zero_bits(
  input signbit,
  input allzeros,
  output [1:0] result);

  assign result = {(allzeros & signbit),(allzeros & ~(signbit))};
endmodule


module dec_regime_8bit(
  input [1:0] signinv,
  input [6:0] shift_onehot,
  output [3:0] regime);

  wire [1:0] inv_rails;
  wire [13:1] regime_onehot;

  dec_regime_onehot_8bit dec_regime_onehot_8bit_regime_onehot(
    .inv_rails (inv_rails),
    .shift_onehot (shift_onehot),
    .regime_onehot (regime_onehot));

  dec_regime_bin_8bit dec_regime_bin_8bit_regime(
    .one_hot_regime (regime_onehot),
    .regime_bin (regime));

  assign inv_rails = {^(signinv), ~^(signinv)};
endmodule


module dec_shift_onehot_8bit(
  input [7:0] posit,
  output [6:0] shift_onehot);

  wire [5:0] xnorlines;
  wire [5:0] xorlines;

  assign xorlines = (posit[5:0] ^ {6{posit[6]}});
  assign xnorlines = ~(xorlines);
  assign shift_onehot[0] = xorlines[5];
  assign shift_onehot[1] = &({xorlines[4],xnorlines[5]});
  assign shift_onehot[2] = &({xorlines[3],xnorlines[5:4]});
  assign shift_onehot[3] = &({xorlines[2],xnorlines[5:3]});
  assign shift_onehot[4] = &({xorlines[1],xnorlines[5:2]});
  assign shift_onehot[5] = &({xorlines[0],xnorlines[5:1]});
  assign shift_onehot[6] = &(xnorlines[5:0]);
endmodule


module dec_expfrac_8bit(
  input [7:0] posit,
  input [6:0] shift_onehot,
  output [4:0] expfrac);

  assign expfrac[0] = (shift_onehot[0] & posit[0]);
  assign expfrac[1] = |(({shift_onehot[0], shift_onehot[1]} & posit[1:0]));
  assign expfrac[2] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2]} & posit[2:0]));
  assign expfrac[3] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3]} & posit[3:0]));
  assign expfrac[4] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4]} & posit[4:0]));
endmodule


module dec_regime_onehot_8bit(
  input [1:0] inv_rails,
  input [6:0] shift_onehot,
  output [13:1] regime_onehot);

  assign regime_onehot[6:1] = ({6{inv_rails[0]}} & {shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5]});
  assign regime_onehot[13:7] = ({7{inv_rails[1]}} & shift_onehot[6:0]);
endmodule


module dec_regime_bin_8bit(
  input [13:1] one_hot_regime,
  output [3:0] regime_bin);

  assign regime_bin[0] = |({one_hot_regime[1], one_hot_regime[3], one_hot_regime[5], one_hot_regime[7], one_hot_regime[9], one_hot_regime[11], one_hot_regime[13]});
  assign regime_bin[1] = |({one_hot_regime[2], one_hot_regime[3], one_hot_regime[6], one_hot_regime[7], one_hot_regime[10], one_hot_regime[11]});
  assign regime_bin[2] = |({one_hot_regime[4], one_hot_regime[5], one_hot_regime[6], one_hot_regime[7], one_hot_regime[12], one_hot_regime[13]});
  assign regime_bin[3] = |({one_hot_regime[8], one_hot_regime[9], one_hot_regime[10], one_hot_regime[11], one_hot_regime[12], one_hot_regime[13]});
endmodule

module decode_posit_8bit(
  input [7:0] posit,
  output [11:0] eposit);

  wire allzeros;
  wire [6:0] shift_onehot;
  wire [1:0] infzeroflags;
  wire [4:0] expfrac_bits;
  wire [3:0] regime_bits;

  dec_inf_zero_bits dec_inf_zero_bits_infzeroflags(
    .signbit (posit[7]),
    .allzeros (allzeros),
    .result (infzeroflags));

  dec_shift_onehot_8bit dec_shift_onehot_8bit_shift_onehot(
    .posit (posit),
    .shift_onehot (shift_onehot));

  dec_expfrac_8bit dec_expfrac_8bit_expfrac_bits(
    .posit (posit),
    .shift_onehot (shift_onehot),
    .expfrac (expfrac_bits));

  dec_regime_8bit dec_regime_8bit_regime_bits(
    .signinv (posit[7:6]),
    .shift_onehot (shift_onehot),
    .regime (regime_bits));

  assign allzeros = ~(|(posit[6:0]));
  assign eposit = {infzeroflags,posit[7],regime_bits,expfrac_bits};
endmodule

