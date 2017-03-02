/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSED */


module enc_efrac_gs_8bit(
  input sign,
  input inv,
  input [4:0] frac,
  input guard,
  input summary,
  output [8:0] efrac_gs);

  wire [1:0] leading_bits;

  assign leading_bits = {^({sign,inv}), ~^({sign,inv})};
  assign efrac_gs = {leading_bits[0],leading_bits[1],frac,guard,summary};
endmodule


module enc_finalizer_8bit(
  input inf,
  input zero,
  input sign,
  input [8:0] shifted_frac_gs,
  output [7:0] posit);

  wire [7:0] provisional_posit;
  wire rounded_flag;
  wire [6:0] rounded_value;
  wire infzero;

  assign rounded_flag = ((shifted_frac_gs[0] & shifted_frac_gs[1]) | (shifted_frac_gs[1] & shifted_frac_gs[2]));
  assign rounded_value = (shifted_frac_gs[8:2] + {6'b000000,rounded_flag});
  assign provisional_posit = {sign,rounded_value};
  assign infzero = (inf | zero);
  assign posit = (({8{infzero}} & {inf,7'b0000000}) | ({8{~(infzero)}} & provisional_posit));
endmodule


module enc_shifted_frac_gs_8bit(
  input [6:0] one_hot,
  input [8:0] ext_frac,
  output [8:0] shifted_frac);

  wire [6:0] summary_accumulator;

  assign summary_accumulator[0] = (one_hot[0] & ext_frac[0]);
  assign summary_accumulator[1] = (one_hot[1] & |(ext_frac[1:0]));
  assign summary_accumulator[2] = (one_hot[2] & |(ext_frac[2:0]));
  assign summary_accumulator[3] = (one_hot[3] & |(ext_frac[3:0]));
  assign summary_accumulator[4] = (one_hot[4] & |(ext_frac[4:0]));
  assign summary_accumulator[5] = (one_hot[5] & |(ext_frac[5:0]));
  assign summary_accumulator[6] = (one_hot[6] & |(ext_frac[6:0]));
  assign shifted_frac[0] = |(summary_accumulator);
  assign shifted_frac[1] = |((one_hot[6:0] & ext_frac[7:1]));
  assign shifted_frac[2] = |({(one_hot[5:0] & ext_frac[7:2]),(one_hot[6] & ext_frac[8])});
  assign shifted_frac[3] = |({(one_hot[4:0] & ext_frac[7:3]),(|(one_hot[6:5]) & ext_frac[8])});
  assign shifted_frac[4] = |({(one_hot[3:0] & ext_frac[7:4]),(|(one_hot[6:4]) & ext_frac[8])});
  assign shifted_frac[5] = |({(one_hot[2:0] & ext_frac[7:5]),(|(one_hot[6:3]) & ext_frac[8])});
  assign shifted_frac[6] = |({(one_hot[1:0] & ext_frac[7:6]),(|(one_hot[6:2]) & ext_frac[8])});
  assign shifted_frac[7] = |({(one_hot[0] & ext_frac[7]),(|(one_hot[6:1]) & ext_frac[8])});
  assign shifted_frac[8] = (|(one_hot) & ext_frac[8]);
endmodule


module enc_regime_onehot_8bit(
  input [2:0] shift_bin,
  output [6:0] regime_onehot);

  wire [2:0] neg_shift_bin;

  assign neg_shift_bin = ~(shift_bin);
  assign regime_onehot[0] = &({neg_shift_bin[0], neg_shift_bin[1], neg_shift_bin[2]});
  assign regime_onehot[1] = &({shift_bin[0], neg_shift_bin[1], neg_shift_bin[2]});
  assign regime_onehot[2] = &({neg_shift_bin[0], shift_bin[1], neg_shift_bin[2]});
  assign regime_onehot[3] = &({shift_bin[0], shift_bin[1], neg_shift_bin[2]});
  assign regime_onehot[4] = &({neg_shift_bin[0], neg_shift_bin[1], shift_bin[2]});
  assign regime_onehot[5] = &({shift_bin[0], neg_shift_bin[1], shift_bin[2]});
  assign regime_onehot[6] = &({neg_shift_bin[0], shift_bin[1], shift_bin[2]});
endmodule


module enc_shift_bin_8bit(
  input [3:0] regime,
  output [3:0] shift_bin);

  wire regime_sign;
  wire [2:0] inv_signed_regime;
  wire [3:0] regime_subtrahend;
  wire [3:0] signed_regime;

  assign regime_subtrahend = 4'b0111;
  assign signed_regime = (regime - regime_subtrahend);
  assign inv_signed_regime = (-(signed_regime[2:0]) - 3'b001);
  assign regime_sign = signed_regime[3];
  assign shift_bin = {signed_regime[3],(({3{regime_sign}} & inv_signed_regime) | ({3{~(regime_sign)}} & signed_regime[2:0]))};
endmodule

module encode_posit_8bit(
  input [11:0] eposit,
  input guard,
  input summary,
  output [7:0] posit);

  wire [3:0] shift_bin;
  wire [8:0] efrac_gs;
  wire [6:0] regime_onehot;
  wire [8:0] shifted_frac_gs;

  enc_shift_bin_8bit enc_shift_bin_8bit_shift_bin(
    .regime (eposit[8:5]),
    .shift_bin (shift_bin));

  enc_regime_onehot_8bit enc_regime_onehot_8bit_regime_onehot(
    .shift_bin (shift_bin[2:0]),
    .regime_onehot (regime_onehot));

  enc_efrac_gs_8bit enc_efrac_gs_8bit_efrac_gs(
    .sign (eposit[9]),
    .inv (shift_bin[3]),
    .frac (eposit[4:0]),
    .guard (guard),
    .summary (summary),
    .efrac_gs (efrac_gs));

  enc_shifted_frac_gs_8bit enc_shifted_frac_gs_8bit_shifted_frac_gs(
    .one_hot (regime_onehot),
    .ext_frac (efrac_gs),
    .shifted_frac (shifted_frac_gs));

  enc_finalizer_8bit enc_finalizer_8bit_posit(
    .inf (eposit[11]),
    .zero (eposit[10]),
    .sign (eposit[9]),
    .shifted_frac_gs (shifted_frac_gs),
    .posit (posit));


endmodule

