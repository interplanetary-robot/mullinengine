/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSED */


module posit_extended_multiplier_8bit_to_8bit(
  input [11:0] lhs,
  input [11:0] rhs,
  output prod_inf,
  output prod_zer,
  output prod_sgn,
  output [10:0] prod_expfrac);

  wire [3:0] lhs_exp;
  wire lhs_inf;
  wire lhs_zer;
  wire rhs_zer;
  wire [4:0] rhs_frac;
  wire rhs_inf;
  wire [6:0] provisional_prod_frac;
  wire lhs_sgn;
  wire rhs_sgn;
  wire [3:0] rhs_exp;
  wire [4:0] lhs_frac;
  wire [5:0] extended_prod_exp;
  wire [12:0] multiplied_frac;

  mul_frac_8bit mul_frac_8bit_multiplied_frac(
    .lhs_sign (lhs_sgn),
    .lhs_frac (lhs_frac),
    .rhs_sign (rhs_sgn),
    .rhs_frac (rhs_frac),
    .multiplied_frac (multiplied_frac));

  mul_frac_trimmer_11bit_to_8bit mul_frac_trimmer_11bit_to_8bit_provisional_prod_frac(
    .untrimmed_fraction (multiplied_frac[10:0]),
    .trimmed_frac (provisional_prod_frac));

  mul_exp_sum mul_exp_sum_extended_prod_exp(
    .prod_sign (prod_sgn),
    .lhs_exp (lhs_exp),
    .rhs_exp (rhs_exp),
    .frac_adjustment (multiplied_frac[12:11]),
    .adj_exp_sum (extended_prod_exp));

  exp_trim_8bit_mul exp_trim_8bit_mul_prod_expfrac(
    .sign (prod_sgn),
    .exp_untrimmed (extended_prod_exp),
    .frc_untrimmed (provisional_prod_frac[6:0]),
    .expfrac (prod_expfrac));

  assign lhs_inf = lhs[11];
  assign lhs_zer = lhs[10];
  assign lhs_sgn = lhs[9];
  assign lhs_exp = lhs[8:5];
  assign lhs_frac = lhs[4:0];
  assign rhs_inf = rhs[11];
  assign rhs_zer = rhs[10];
  assign rhs_sgn = rhs[9];
  assign rhs_exp = rhs[8:5];
  assign rhs_frac = rhs[4:0];
  assign prod_inf = (lhs_inf | rhs_inf);
  assign prod_zer = (lhs_zer | rhs_zer);
  assign prod_sgn = (lhs_sgn ^ rhs_sgn);
endmodule


module mul_frac_8bit(
  input lhs_sign,
  input [4:0] lhs_frac,
  input rhs_sign,
  input [4:0] rhs_frac,
  output [12:0] multiplied_frac);

  wire top_hidden_bit;
  wire [6:0] lhs_sum_result;
  wire [9:0] mul_big_frac;
  wire next_hidden_bit;
  wire [6:0] rhs_frac_lhs_sign;
  wire [1:0] frac_report;
  wire [6:0] lhs_frac_rhs_sign;
  wire [11:0] full_sum_result;
  wire [11:0] general_mul_result;
  wire [10:0] shifted_frac;

  mul_frac_hidden_crossmultiplier_8bit mul_frac_hidden_crossmultiplier_8bit_lhs_frac_rhs_sign(
    .crosssign (rhs_sign),
    .frac (lhs_frac),
    .result (lhs_frac_rhs_sign));

  mul_frac_hidden_crossmultiplier_8bit mul_frac_hidden_crossmultiplier_8bit_rhs_frac_lhs_sign(
    .crosssign (lhs_sign),
    .frac (rhs_frac),
    .result (rhs_frac_lhs_sign));

  mul_frac_finisher_bitsbit mul_frac_finisher_bitsbit_frac_report_shifted_frac(
    .final_sign (top_hidden_bit),
    .provisional_fraction (full_sum_result),
    .exponent_augment (frac_report),
    .shifted_fraction (shifted_frac));

  assign top_hidden_bit = (lhs_sign ^ rhs_sign);
  assign next_hidden_bit = ~((lhs_sign | rhs_sign));
  assign mul_big_frac = (lhs_frac * rhs_frac);
  assign general_mul_result = {top_hidden_bit,next_hidden_bit,mul_big_frac};
  assign lhs_sum_result = (lhs_frac_rhs_sign + general_mul_result[11:5]);
  assign full_sum_result = {(rhs_frac_lhs_sign + lhs_sum_result),general_mul_result[4:0]};
  assign multiplied_frac = {frac_report,shifted_frac};
endmodule


module exp_trim_8bit_mul(
  input sign,
  input [5:0] exp_untrimmed,
  input [6:0] frc_untrimmed,
  output [10:0] expfrac);

  wire do_exp_clipping;
  wire [5:0] positive_limit_exp;
  wire [3:0] clipping_value;
  wire [6:0] frc_trimmed;
  wire [3:0] exp_trimmed;
  wire overflowed;
  wire [5:0] negative_limit_exp;
  wire underflowed;

  assign positive_limit_exp = 6'b001101;
  assign negative_limit_exp = 6'b001100;
  assign underflowed = (exp_untrimmed[5] | (~(sign) & ~(|(exp_untrimmed))));
  assign overflowed = (((~(exp_untrimmed[5]) & ~(sign)) & (exp_untrimmed > positive_limit_exp)) | ((~(exp_untrimmed[5]) & sign) & (exp_untrimmed > negative_limit_exp)));
  assign clipping_value[3:1] = ({3'b110} & {3{overflowed}});
  assign clipping_value[0] = ~(sign);
  assign do_exp_clipping = (underflowed | overflowed);
  assign exp_trimmed = ((exp_untrimmed[3:0] & {4{~(do_exp_clipping)}}) | (clipping_value & {4{do_exp_clipping}}));
  assign frc_trimmed = ((frc_untrimmed[6:0] & {7{(~((overflowed | underflowed)) | (overflowed ^ sign))}}) | {7{((overflowed | underflowed) & (overflowed ^ sign))}});
  assign expfrac = {exp_trimmed,frc_trimmed};
endmodule


module mul_exp_sum(
  input prod_sign,
  input [3:0] lhs_exp,
  input [3:0] rhs_exp,
  input [1:0] frac_adjustment,
  output [5:0] adj_exp_sum);

  wire [5:0] dual_exp_sum;
  wire [5:0] lhs_exp_sum;
  wire [5:0] bias_wire;

  assign bias_wire = 6'b111001;
  assign lhs_exp_sum = (bias_wire + {2'b00,lhs_exp});
  assign dual_exp_sum = (lhs_exp_sum + {2'b00,rhs_exp});
  assign adj_exp_sum = (dual_exp_sum + {4'b0000,frac_adjustment});
endmodule


module mul_frac_trimmer_11bit_to_8bit(
  input [10:0] untrimmed_fraction,
  output [6:0] trimmed_frac);

  wire summ_val;
  wire [4:0] frac_val;
  wire guard_val;

  assign frac_val = untrimmed_fraction[10:6];
  assign guard_val = untrimmed_fraction[5];
  assign summ_val = |(untrimmed_fraction[4:0]);
  assign trimmed_frac = {frac_val,guard_val,summ_val};
endmodule


module mul_frac_hidden_crossmultiplier_8bit(
  input crosssign,
  input [4:0] frac,
  output [6:0] result);

  wire [4:0] selected_inv_frac;
  wire top_neg;
  wire [4:0] selected_frac;
  wire [4:0] inv_frac;

  assign inv_frac = -(frac);
  assign top_neg = (|(inv_frac) & crosssign);
  assign selected_inv_frac = (inv_frac & {5{crosssign}});
  assign selected_frac = (frac & {5{~(crosssign)}});
  assign result = {top_neg,selected_inv_frac[4],(selected_inv_frac[3:0] | selected_frac[4:1]),selected_frac[0]};
endmodule


module mul_frac_finisher_bitsbit(
  input final_sign,
  input [11:0] provisional_fraction,
  output [1:0] exponent_augment,
  output [10:0] shifted_fraction);

  wire [10:0] selected_two_shift_fraction;
  wire shift_selector;
  wire [10:0] selected_one_shift_fraction;

  assign shift_selector = (final_sign ^ provisional_fraction[11]);
  assign exponent_augment[1] = (~((provisional_fraction[11] | provisional_fraction[10])) & ~(final_sign));
  assign exponent_augment[0] = shift_selector;
  assign selected_one_shift_fraction = ({11{shift_selector}} & provisional_fraction[10:0]);
  assign selected_two_shift_fraction = ({11{~(shift_selector)}} & {provisional_fraction[9:0],1'b0});
  assign shifted_fraction = (selected_one_shift_fraction | selected_two_shift_fraction);
endmodule

module posit_multiplier_8bit_to_8bit(
  input [7:0] lhs,
  input [7:0] rhs,
  output [7:0] mul_result);

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

  posit_extended_multiplier_8bit_to_8bit posit_extended_multiplier_8bit_to_8bit_res_inf_res_zer_res_sgn_res_expfrac(
    .lhs (lhs_extended),
    .rhs (rhs_extended),
    .prod_inf (res_inf),
    .prod_zer (res_zer),
    .prod_sgn (res_sgn),
    .prod_expfrac (res_expfrac));

  encode_posit_8bit encode_posit_8bit_mul_result(
    .p_inf (res_inf),
    .p_zer (res_zer),
    .p_sgn (res_sgn),
    .p_exp (res_expfrac[10:7]),
    .p_frc (res_expfrac[6:2]),
    .p_gs (res_expfrac[1:0]),
    .posit (mul_result));


endmodule

