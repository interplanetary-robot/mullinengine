/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSED */


module posit_extended_adder_8bit(
  input [11:0] lhs_e,
  input [11:0] rhs_e,
  output s_inf_tmp,
  output s_zer_tmp,
  output s_sgn_tmp,
  output [10:0] s_expfrc_tmp);

  wire [3:0] lhs_exp;
  wire sum_nan;
  wire [7:0] frc_shift_onehot;
  wire [4:0] sum_exp_diff;
  wire lhs_inf;
  wire [3:0] provisional_exp;
  wire lhs_zer;
  wire rhs_zer;
  wire [4:0] rhs_frac;
  wire [7:0] lhs_aug_frac;
  wire rhs_inf;
  wire sum_inf;
  wire sum_zer;
  wire lhs_sgn;
  wire [3:0] lhs_dom_exp;
  wire [8:0] rhs_dom_frc;
  wire rhs_sgn;
  wire [3:0] rhs_exp;
  wire [8:0] provisional_frc;
  wire [4:0] lhs_frac;
  wire [4:0] sum_exp_untrimmed;
  wire [3:0] sum_exp;
  wire [4:0] sum_frc;
  wire [3:0] rhs_dom_exp;
  wire [1:0] sum_gs;
  wire zero_sum;
  wire [8:0] lhs_dom_frc;
  wire [6:0] sum_frc_untrimmed;
  wire [7:0] rhs_aug_frac;
  wire sum_sgn;
  wire sum_zer2;
  wire [11:0] zeroed_result;
  wire [13:0] posit_sum;
  wire rhs_wins;
  wire sum_zer1;
  wire lhs_wins;

  add_zero_checker_8bit add_zero_checker_8bit_sum_zer2(
    .lhs_sgn (lhs_sgn),
    .lhs_exp (lhs_exp),
    .lhs_frac (lhs_frac),
    .rhs_sgn (rhs_sgn),
    .rhs_exp (rhs_exp),
    .rhs_frac (rhs_frac),
    .iszero (sum_zer2));

  add_theoretical_8bit add_theoretical_8bit_lhs_wins_lhs_dom_exp_lhs_dom_frc(
    .dom_exp (lhs_exp),
    .dom_frac (lhs_aug_frac),
    .sub_exp (rhs_exp),
    .sub_frac (rhs_aug_frac),
    .fraction_win (lhs_wins),
    .provisional_exp (lhs_dom_exp),
    .provisional_frac (lhs_dom_frc));

  add_theoretical_8bit add_theoretical_8bit_rhs_wins_rhs_dom_exp_rhs_dom_frc(
    .dom_exp (rhs_exp),
    .dom_frac (rhs_aug_frac),
    .sub_exp (lhs_exp),
    .sub_frac (lhs_aug_frac),
    .fraction_win (rhs_wins),
    .provisional_exp (rhs_dom_exp),
    .provisional_frac (rhs_dom_frc));

  add_shift_onehot_8bit add_shift_onehot_8bit_frc_shift_onehot(
    .sign (sum_sgn),
    .provisional_sum_frac (provisional_frc),
    .leading_onehot (frc_shift_onehot));

  add_apply_shift_8bit add_apply_shift_8bit_sum_frc_untrimmed(
    .efraction (provisional_frc),
    .shift_onehot (frc_shift_onehot),
    .shifted_fraction (sum_frc_untrimmed));

  add_shift_diff_8bit add_shift_diff_8bit_sum_exp_diff(
    .shift_onehot (frc_shift_onehot),
    .exponent_delta (sum_exp_diff));

  add_exp_diff_8bit add_exp_diff_8bit_sum_exp_untrimmed(
    .old_exp (provisional_exp),
    .exp_delta (sum_exp_diff),
    .new_exp (sum_exp_untrimmed));

  exp_trim_8bit_add exp_trim_8bit_add_sum_exp_sum_frc_sum_gs(
    .sign (sum_sgn),
    .exp_untrimmed (sum_exp_untrimmed),
    .frc_untrimmed (sum_frc_untrimmed),
    .exp_trimmed (sum_exp),
    .frc_out (sum_frc),
    .gs_bits (sum_gs));

  assign lhs_inf = lhs_e[11];
  assign lhs_zer = lhs_e[10];
  assign lhs_sgn = lhs_e[9];
  assign lhs_exp = lhs_e[8:5];
  assign lhs_frac = lhs_e[4:0];
  assign rhs_inf = rhs_e[11];
  assign rhs_zer = rhs_e[10];
  assign rhs_sgn = rhs_e[9];
  assign rhs_exp = rhs_e[8:5];
  assign rhs_frac = rhs_e[4:0];
  assign sum_inf = (lhs_inf | rhs_inf);
  assign sum_nan = ((lhs_inf & rhs_inf) | ((lhs_inf & lhs_zer) | (rhs_inf & rhs_zer)));
  assign sum_zer1 = (lhs_zer & rhs_zer);
  assign sum_zer = ((sum_zer1 | sum_zer2) | sum_nan);
  assign zeroed_result = ((rhs_e & {12{lhs_zer}}) | (lhs_e & {12{rhs_zer}}));
  assign zero_sum = (lhs_zer | rhs_zer);
  assign lhs_aug_frac = {lhs_sgn,~(lhs_sgn),lhs_frac,1'b0};
  assign rhs_aug_frac = {rhs_sgn,~(rhs_sgn),rhs_frac,1'b0};
  assign sum_sgn = (((lhs_wins & lhs_sgn) | (rhs_wins & rhs_sgn)) | (lhs_sgn & rhs_sgn));
  assign provisional_frc = (lhs_dom_frc | rhs_dom_frc);
  assign provisional_exp = (lhs_dom_exp | rhs_dom_exp);
  assign posit_sum = (({14{~(zero_sum)}} & {sum_inf,sum_zer,sum_sgn,sum_exp,sum_frc,sum_gs}) | ({14{zero_sum}} & {zeroed_result,2'b00}));
  assign s_inf_tmp = posit_sum[13];
  assign s_zer_tmp = posit_sum[12];
  assign s_sgn_tmp = posit_sum[11];
  assign s_expfrc_tmp = posit_sum[10:0];
endmodule


module add_theoretical_8bit(
  input [3:0] dom_exp,
  input [7:0] dom_frac,
  input [3:0] sub_exp,
  input [7:0] sub_frac,
  output fraction_win,
  output [3:0] provisional_exp,
  output [8:0] provisional_frac);

  wire [6:0] shft_sub_frac;
  wire [8:0] sub_frac_gs;
  wire [4:0] sum_exp;
  wire nuke_me;
  wire [8:0] dfraction;
  wire [4:0] esub_exp;
  wire [4:0] edom_exp;
  wire [3:0] shift;
  wire [15:0] sum_frac;
  wire should_round;
  wire [13:0] rfraction;

  add_rightshift_8bit add_rightshift_8bit_shft_sub_frac_sub_frac_gs(
    .fraction (sub_frac),
    .shift (shift),
    .frac_rs (shft_sub_frac),
    .frac_gs (sub_frac_gs));

  assign edom_exp = {1'b0,dom_exp};
  assign esub_exp = {1'b0,sub_exp};
  assign sum_exp = (edom_exp - esub_exp);
  assign nuke_me = sum_exp[4];
  assign shift = sum_exp[3:0];
  assign sum_frac = ({dom_frac,8'b00000000} + {shft_sub_frac,sub_frac_gs});
  assign should_round = ((sum_frac[2] & sum_frac[1]) | (sum_frac[1] & sum_frac[0]));
  assign rfraction = (sum_frac[15:2] + {13'b0000000000000,should_round});
  assign dfraction = {rfraction[13:6],|(rfraction[5:0])};
  assign fraction_win = ~(((dom_frac[7] ^ dfraction[8]) | nuke_me));
  assign provisional_exp = (dom_exp & {4{~(nuke_me)}});
  assign provisional_frac = ({dfraction} & {9{~(nuke_me)}});
endmodule


module add_zero_checker_8bit(
  input lhs_sgn,
  input [3:0] lhs_exp,
  input [4:0] lhs_frac,
  input rhs_sgn,
  input [3:0] rhs_exp,
  input [4:0] rhs_frac,
  output iszero);

  wire frac_match;
  wire [3:0] augmented_rhs;
  wire [3:0] augmented_lhs;
  wire exp_match;
  wire rhs_sgn_augment;
  wire lhs_sgn_augment;

  assign lhs_sgn_augment = (~(|(lhs_frac)) & lhs_sgn);
  assign rhs_sgn_augment = (~(|(rhs_frac)) & rhs_sgn);
  assign augmented_lhs = ({3'b000,lhs_sgn_augment} + lhs_exp);
  assign augmented_rhs = ({3'b000,rhs_sgn_augment} + rhs_exp);
  assign exp_match = ~(|((augmented_lhs ^ augmented_rhs)));
  assign frac_match = ~(|((lhs_frac + rhs_frac)));
  assign iszero = ((lhs_sgn ^ rhs_sgn) & (exp_match & frac_match));
endmodule


module exp_trim_8bit_add(
  input sign,
  input [4:0] exp_untrimmed,
  input [6:0] frc_untrimmed,
  output [3:0] exp_trimmed,
  output [4:0] frc_out,
  output [1:0] gs_bits);

  wire do_exp_clipping;
  wire [4:0] positive_limit_exp;
  wire [3:0] clipping_value;
  wire [6:0] frc_trimmed;
  wire overflowed;
  wire [4:0] negative_limit_exp;
  wire underflowed;

  assign positive_limit_exp = 5'b01101;
  assign negative_limit_exp = 5'b01100;
  assign underflowed = (exp_untrimmed[4] | (~(sign) & ~(|(exp_untrimmed))));
  assign overflowed = (((~(exp_untrimmed[4]) & ~(sign)) & (exp_untrimmed > positive_limit_exp)) | ((~(exp_untrimmed[4]) & sign) & (exp_untrimmed > negative_limit_exp)));
  assign clipping_value[3:1] = ({3'b110} & {3{overflowed}});
  assign clipping_value[0] = ~(sign);
  assign do_exp_clipping = (underflowed | overflowed);
  assign exp_trimmed = ((exp_untrimmed[3:0] & {4{~(do_exp_clipping)}}) | (clipping_value & {4{do_exp_clipping}}));
  assign frc_trimmed = ((frc_untrimmed[6:0] & {7{(~((overflowed | underflowed)) | (overflowed ^ sign))}}) | {7{((overflowed | underflowed) & (overflowed ^ sign))}});
  assign gs_bits = frc_trimmed[1:0];
  assign frc_out = frc_trimmed[6:2];
endmodule


module add_shift_onehot_8bit(
  input sign,
  input [8:0] provisional_sum_frac,
  output [7:0] leading_onehot);

  wire [8:0] sumvalue;

  assign sumvalue = (provisional_sum_frac ^ {9{sign}});
  assign leading_onehot[0] = sumvalue[8];
  assign leading_onehot[1] = (~({sumvalue[8]}) & sumvalue[7]);
  assign leading_onehot[2] = (~(|({sumvalue[8],sumvalue[7]})) & sumvalue[6]);
  assign leading_onehot[3] = (~(|({sumvalue[8],sumvalue[7],sumvalue[6]})) & sumvalue[5]);
  assign leading_onehot[4] = (~(|({sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5]})) & sumvalue[4]);
  assign leading_onehot[5] = (~(|({sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4]})) & sumvalue[3]);
  assign leading_onehot[6] = (~(|({sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4],sumvalue[3]})) & sumvalue[2]);
  assign leading_onehot[7] = (~(|({sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4],sumvalue[3],sumvalue[2]})) & sumvalue[1]);
endmodule


module add_exp_diff_8bit(
  input [3:0] old_exp,
  input [4:0] exp_delta,
  output [4:0] new_exp);

  assign new_exp = ({1'b0,old_exp} + exp_delta);
endmodule


module add_shift_diff_8bit(
  input [7:0] shift_onehot,
  output [4:0] exponent_delta);

  assign exponent_delta[0] = |({shift_onehot[0],shift_onehot[2],shift_onehot[4],shift_onehot[6]});
  assign exponent_delta[1] = |({shift_onehot[2],shift_onehot[3],shift_onehot[6],shift_onehot[7]});
  assign exponent_delta[2] = |({shift_onehot[2],shift_onehot[3],shift_onehot[4],shift_onehot[5]});
  assign exponent_delta[3] = |({shift_onehot[2],shift_onehot[3],shift_onehot[4],shift_onehot[5],shift_onehot[6],shift_onehot[7]});
  assign exponent_delta[4] = ~((shift_onehot[0] | shift_onehot[1]));
endmodule


module add_apply_shift_8bit(
  input [8:0] efraction,
  input [7:0] shift_onehot,
  output [6:0] shifted_fraction);

  assign shifted_fraction[0] = (((shift_onehot[0] & efraction[1]) | (shift_onehot[0] & efraction[0])) | (shift_onehot[1] & efraction[0]));
  assign shifted_fraction[1] = (((shift_onehot[0] & efraction[2]) | (shift_onehot[1] & efraction[1])) | (shift_onehot[2] & efraction[0]));
  assign shifted_fraction[2] = |({(shift_onehot[0] & efraction[3]),(shift_onehot[1] & efraction[2]),(shift_onehot[2] & efraction[1])});
  assign shifted_fraction[3] = |({(shift_onehot[0] & efraction[4]),(shift_onehot[1] & efraction[3]),(shift_onehot[2] & efraction[2]),(shift_onehot[3] & efraction[1])});
  assign shifted_fraction[4] = |({(shift_onehot[0] & efraction[5]),(shift_onehot[1] & efraction[4]),(shift_onehot[2] & efraction[3]),(shift_onehot[3] & efraction[2]),(shift_onehot[4] & efraction[1])});
  assign shifted_fraction[5] = |({(shift_onehot[0] & efraction[6]),(shift_onehot[1] & efraction[5]),(shift_onehot[2] & efraction[4]),(shift_onehot[3] & efraction[3]),(shift_onehot[4] & efraction[2]),(shift_onehot[5] & efraction[1])});
  assign shifted_fraction[6] = |({(shift_onehot[0] & efraction[7]),(shift_onehot[1] & efraction[6]),(shift_onehot[2] & efraction[5]),(shift_onehot[3] & efraction[4]),(shift_onehot[4] & efraction[3]),(shift_onehot[5] & efraction[2]),(shift_onehot[6] & efraction[1])});
endmodule


module add_rightshift_8bit(
  input [7:0] fraction,
  input [3:0] shift,
  output [6:0] frac_rs,
  output [8:0] frac_gs);

  wire [14:0] rightshifted_frac;
  wire [13:8] summary_wires;
  wire summary_bit;

  assign rightshifted_frac = ($signed({fraction,7'b0000000}) >>> shift);
  assign summary_wires[8] = ((4'b1000 == shift) & fraction[0]);
  assign summary_wires[9] = ((4'b1001 == shift) & |(fraction[1:0]));
  assign summary_wires[10] = ((4'b1010 == shift) & |(fraction[2:0]));
  assign summary_wires[11] = ((4'b1011 == shift) & |(fraction[3:0]));
  assign summary_wires[12] = ((4'b1100 == shift) & |(fraction[4:0]));
  assign summary_wires[13] = ((4'b1101 == shift) & |(fraction[5:0]));
  assign summary_bit = |(summary_wires);
  assign frac_rs = rightshifted_frac[14:8];
  assign frac_gs = {rightshifted_frac[7:0],summary_bit};
endmodule

module posit_adder_8bit(
  input [7:0] lhs,
  input [7:0] rhs,
  output [7:0] add_result);

  wire res_zer;
  wire [11:0] lhs_extended;
  wire res_inf;
  wire [10:0] res_expfrac;
  wire res_sgn;
  wire [11:0] rhs_extended;

  decode_posit_8bit decode_posit_8bit_lhs_extended(
    .posit (lhs),
    .eposit (lhs_extended));

  decode_posit_8bit decode_posit_8bit_rhs_extended(
    .posit (rhs),
    .eposit (rhs_extended));

  posit_extended_adder_8bit posit_extended_adder_8bit_res_inf_res_zer_res_sgn_res_expfrac(
    .lhs_e (lhs_extended),
    .rhs_e (rhs_extended),
    .s_inf_tmp (res_inf),
    .s_zer_tmp (res_zer),
    .s_sgn_tmp (res_sgn),
    .s_expfrc_tmp (res_expfrac));

  encode_posit_8bit encode_posit_8bit_add_result(
    .p_inf (res_inf),
    .p_zer (res_zer),
    .p_sgn (res_sgn),
    .p_exp (res_expfrac[10:7]),
    .p_frc (res_expfrac[6:2]),
    .p_gs (res_expfrac[1:0]),
    .posit (add_result));


endmodule

