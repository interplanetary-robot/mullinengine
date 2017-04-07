/* verilator lint_off DECLFILENAME */
/* verilator lint_off UNUSED */
/* verilator lint_off PINMISSING */


module mullinrow_2(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[1]),
    .lhs_e (vec_e[1]),
    .lhs_f (vec_f[1]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[1] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[1] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[1] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[1] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[1] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[1] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[1] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[1] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module decode_posit_wrapper16(
  input [15:0] xposit,
  output [23:0] decoded_posit);

  wire [20:0] unrolled_posit;

  decode_posit_16bit decode_posit_16bit_unrolled_posit(
    .posit (xposit),
    .eposit (unrolled_posit));

  assign decoded_posit = {unrolled_posit,3'b000};
endmodule


module mullinrow_6(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[5]),
    .lhs_e (vec_e[5]),
    .lhs_f (vec_f[5]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[5] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[5] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[5] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[5] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[5] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[5] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[5] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[5] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module encode_posit_wrapper(
  input [23:0] xposit,
  output [15:0] result);

  wire [1:0] gs;

  encode_posit_16bit encode_posit_16bit_result(
    .p_inf (xposit[23]),
    .p_zer (xposit[22]),
    .p_sgn (xposit[21]),
    .p_exp (xposit[20:16]),
    .p_frc (xposit[15:3]),
    .p_gs (gs),
    .posit (result));

  assign gs = {xposit[2],|(xposit[1:0])};
endmodule


module mullinrow_5(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[4]),
    .lhs_e (vec_e[4]),
    .lhs_f (vec_f[4]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[4] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[4] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[4] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[4] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[4] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[4] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[4] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[4] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module mullinrow_3(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[2]),
    .lhs_e (vec_e[2]),
    .lhs_f (vec_f[2]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[2] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[2] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[2] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[2] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[2] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[2] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[2] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[2] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module mullinrow_4(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[3]),
    .lhs_e (vec_e[3]),
    .lhs_f (vec_f[3]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[3] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[3] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[3] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[3] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[3] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[3] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[3] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[3] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module mullinrow_8(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[7]),
    .lhs_e (vec_e[7]),
    .lhs_f (vec_f[7]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[7] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[7] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[7] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[7] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[7] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[7] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[7] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[7] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module mullinrow_7(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[6]),
    .lhs_e (vec_e[6]),
    .lhs_f (vec_f[6]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[6] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[6] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[6] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[6] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[6] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[6] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[6] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[6] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module mullinrow_1(
  input [119:0] vec,
  input [191:0] acc,
  input [119:0] mtx,
  output [191:0] result_acc);

  wire add_sgn[7:0];
  wire [15:0] mul_f[7:0];
  wire [4:0] ur_acc_e[7:0];
  wire [3:0] mtx_e[7:0];
  wire [4:0] acc_e[7:0];
  wire [4:0] add_e[7:0];
  wire [2:0] mtx_s[7:0];
  wire [7:0] mtx_f[7:0];
  wire [2:0] mul_s[7:0];
  wire [3:0] vec_e[7:0];
  wire [2:0] acc_s[7:0];
  wire [15:0] mul_raw_f[7:0];
  wire [15:0] acc_f[7:0];
  wire [15:0] ur_acc_f[7:0];
  wire add_zer[7:0];
  wire [4:0] add_provisional_exp[7:0];
  wire [2:0] add_s[7:0];
  wire [2:0] vec_s[7:0];
  wire [17:0] add_provisional_frc[7:0];
  wire [4:0] mul_e[7:0];
  wire [7:0] vec_f[7:0];
  wire [15:0] add_f[7:0];

  round_accumulator__16bit round_accumulator__16bit_acc_e_0_acc_f_0(
    .acc_s (acc_s[0]),
    .ur_acc_e (ur_acc_e[0]),
    .ur_acc_f (ur_acc_f[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_1_acc_f_1(
    .acc_s (acc_s[1]),
    .ur_acc_e (ur_acc_e[1]),
    .ur_acc_f (ur_acc_f[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_2_acc_f_2(
    .acc_s (acc_s[2]),
    .ur_acc_e (ur_acc_e[2]),
    .ur_acc_f (ur_acc_f[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_3_acc_f_3(
    .acc_s (acc_s[3]),
    .ur_acc_e (ur_acc_e[3]),
    .ur_acc_f (ur_acc_f[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_4_acc_f_4(
    .acc_s (acc_s[4]),
    .ur_acc_e (ur_acc_e[4]),
    .ur_acc_f (ur_acc_f[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_5_acc_f_5(
    .acc_s (acc_s[5]),
    .ur_acc_e (ur_acc_e[5]),
    .ur_acc_f (ur_acc_f[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_6_acc_f_6(
    .acc_s (acc_s[6]),
    .ur_acc_e (ur_acc_e[6]),
    .ur_acc_f (ur_acc_f[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]));

  round_accumulator__16bit round_accumulator__16bit_acc_e_7_acc_f_7(
    .acc_s (acc_s[7]),
    .ur_acc_e (ur_acc_e[7]),
    .ur_acc_f (ur_acc_f[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_0_mul_e_0_mul_f_0(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[0]),
    .rhs_e (mtx_e[0]),
    .rhs_f (mtx_f[0]),
    .raw_m (mul_raw_f[0]),
    .prod_s (mul_s[0]),
    .prod_exp (mul_e[0]),
    .prod_frc (mul_f[0]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_1_mul_e_1_mul_f_1(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[1]),
    .rhs_e (mtx_e[1]),
    .rhs_f (mtx_f[1]),
    .raw_m (mul_raw_f[1]),
    .prod_s (mul_s[1]),
    .prod_exp (mul_e[1]),
    .prod_frc (mul_f[1]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_2_mul_e_2_mul_f_2(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[2]),
    .rhs_e (mtx_e[2]),
    .rhs_f (mtx_f[2]),
    .raw_m (mul_raw_f[2]),
    .prod_s (mul_s[2]),
    .prod_exp (mul_e[2]),
    .prod_frc (mul_f[2]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_3_mul_e_3_mul_f_3(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[3]),
    .rhs_e (mtx_e[3]),
    .rhs_f (mtx_f[3]),
    .raw_m (mul_raw_f[3]),
    .prod_s (mul_s[3]),
    .prod_exp (mul_e[3]),
    .prod_frc (mul_f[3]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_4_mul_e_4_mul_f_4(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[4]),
    .rhs_e (mtx_e[4]),
    .rhs_f (mtx_f[4]),
    .raw_m (mul_raw_f[4]),
    .prod_s (mul_s[4]),
    .prod_exp (mul_e[4]),
    .prod_frc (mul_f[4]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_5_mul_e_5_mul_f_5(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[5]),
    .rhs_e (mtx_e[5]),
    .rhs_f (mtx_f[5]),
    .raw_m (mul_raw_f[5]),
    .prod_s (mul_s[5]),
    .prod_exp (mul_e[5]),
    .prod_frc (mul_f[5]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_6_mul_e_6_mul_f_6(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[6]),
    .rhs_e (mtx_e[6]),
    .rhs_f (mtx_f[6]),
    .raw_m (mul_raw_f[6]),
    .prod_s (mul_s[6]),
    .prod_exp (mul_e[6]),
    .prod_frc (mul_f[6]));

  mullin_mul_8_to_16bit mullin_mul_8_to_16bit_mul_s_7_mul_e_7_mul_f_7(
    .lhs_s (vec_s[0]),
    .lhs_e (vec_e[0]),
    .lhs_f (vec_f[0]),
    .rhs_s (mtx_s[7]),
    .rhs_e (mtx_e[7]),
    .rhs_f (mtx_f[7]),
    .raw_m (mul_raw_f[7]),
    .prod_s (mul_s[7]),
    .prod_exp (mul_e[7]),
    .prod_frc (mul_f[7]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_0_add_provisional_exp_0_add_provisional_frc_0(
    .acc_s (acc_s[0]),
    .acc_e (acc_e[0]),
    .acc_f (acc_f[0]),
    .mul_s (mul_s[0]),
    .mul_e (mul_e[0]),
    .mul_f (mul_f[0]),
    .res_sgn (add_sgn[0]),
    .res_exp (add_provisional_exp[0]),
    .res_frc (add_provisional_frc[0]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_0(
    .lhs_s (acc_s[0]),
    .lhs_exp (acc_e[0]),
    .lhs_frac (acc_f[0][15:3]),
    .rhs_s (mul_s[0]),
    .rhs_exp (mul_e[0]),
    .rhs_frac (mul_f[0][15:3]),
    .iszero (add_zer[0]));

  mullin_addition_state mullin_addition_state_add_s_0(
    .acc_s (acc_s[0]),
    .mul_s (mul_s[0]),
    .sum_sgn (add_sgn[0]),
    .sum_zerocheck (add_zer[0]),
    .add_state (add_s[0]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_0_add_f_0(
    .sgn (add_sgn[0]),
    .provisional_exp (add_provisional_exp[0]),
    .provisional_frc (add_provisional_frc[0]),
    .sum_exp (add_e[0]),
    .sum_frc (add_f[0]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_1_add_provisional_exp_1_add_provisional_frc_1(
    .acc_s (acc_s[1]),
    .acc_e (acc_e[1]),
    .acc_f (acc_f[1]),
    .mul_s (mul_s[1]),
    .mul_e (mul_e[1]),
    .mul_f (mul_f[1]),
    .res_sgn (add_sgn[1]),
    .res_exp (add_provisional_exp[1]),
    .res_frc (add_provisional_frc[1]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_1(
    .lhs_s (acc_s[1]),
    .lhs_exp (acc_e[1]),
    .lhs_frac (acc_f[1][15:3]),
    .rhs_s (mul_s[1]),
    .rhs_exp (mul_e[1]),
    .rhs_frac (mul_f[1][15:3]),
    .iszero (add_zer[1]));

  mullin_addition_state mullin_addition_state_add_s_1(
    .acc_s (acc_s[1]),
    .mul_s (mul_s[1]),
    .sum_sgn (add_sgn[1]),
    .sum_zerocheck (add_zer[1]),
    .add_state (add_s[1]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_1_add_f_1(
    .sgn (add_sgn[1]),
    .provisional_exp (add_provisional_exp[1]),
    .provisional_frc (add_provisional_frc[1]),
    .sum_exp (add_e[1]),
    .sum_frc (add_f[1]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_2_add_provisional_exp_2_add_provisional_frc_2(
    .acc_s (acc_s[2]),
    .acc_e (acc_e[2]),
    .acc_f (acc_f[2]),
    .mul_s (mul_s[2]),
    .mul_e (mul_e[2]),
    .mul_f (mul_f[2]),
    .res_sgn (add_sgn[2]),
    .res_exp (add_provisional_exp[2]),
    .res_frc (add_provisional_frc[2]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_2(
    .lhs_s (acc_s[2]),
    .lhs_exp (acc_e[2]),
    .lhs_frac (acc_f[2][15:3]),
    .rhs_s (mul_s[2]),
    .rhs_exp (mul_e[2]),
    .rhs_frac (mul_f[2][15:3]),
    .iszero (add_zer[2]));

  mullin_addition_state mullin_addition_state_add_s_2(
    .acc_s (acc_s[2]),
    .mul_s (mul_s[2]),
    .sum_sgn (add_sgn[2]),
    .sum_zerocheck (add_zer[2]),
    .add_state (add_s[2]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_2_add_f_2(
    .sgn (add_sgn[2]),
    .provisional_exp (add_provisional_exp[2]),
    .provisional_frc (add_provisional_frc[2]),
    .sum_exp (add_e[2]),
    .sum_frc (add_f[2]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_3_add_provisional_exp_3_add_provisional_frc_3(
    .acc_s (acc_s[3]),
    .acc_e (acc_e[3]),
    .acc_f (acc_f[3]),
    .mul_s (mul_s[3]),
    .mul_e (mul_e[3]),
    .mul_f (mul_f[3]),
    .res_sgn (add_sgn[3]),
    .res_exp (add_provisional_exp[3]),
    .res_frc (add_provisional_frc[3]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_3(
    .lhs_s (acc_s[3]),
    .lhs_exp (acc_e[3]),
    .lhs_frac (acc_f[3][15:3]),
    .rhs_s (mul_s[3]),
    .rhs_exp (mul_e[3]),
    .rhs_frac (mul_f[3][15:3]),
    .iszero (add_zer[3]));

  mullin_addition_state mullin_addition_state_add_s_3(
    .acc_s (acc_s[3]),
    .mul_s (mul_s[3]),
    .sum_sgn (add_sgn[3]),
    .sum_zerocheck (add_zer[3]),
    .add_state (add_s[3]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_3_add_f_3(
    .sgn (add_sgn[3]),
    .provisional_exp (add_provisional_exp[3]),
    .provisional_frc (add_provisional_frc[3]),
    .sum_exp (add_e[3]),
    .sum_frc (add_f[3]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_4_add_provisional_exp_4_add_provisional_frc_4(
    .acc_s (acc_s[4]),
    .acc_e (acc_e[4]),
    .acc_f (acc_f[4]),
    .mul_s (mul_s[4]),
    .mul_e (mul_e[4]),
    .mul_f (mul_f[4]),
    .res_sgn (add_sgn[4]),
    .res_exp (add_provisional_exp[4]),
    .res_frc (add_provisional_frc[4]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_4(
    .lhs_s (acc_s[4]),
    .lhs_exp (acc_e[4]),
    .lhs_frac (acc_f[4][15:3]),
    .rhs_s (mul_s[4]),
    .rhs_exp (mul_e[4]),
    .rhs_frac (mul_f[4][15:3]),
    .iszero (add_zer[4]));

  mullin_addition_state mullin_addition_state_add_s_4(
    .acc_s (acc_s[4]),
    .mul_s (mul_s[4]),
    .sum_sgn (add_sgn[4]),
    .sum_zerocheck (add_zer[4]),
    .add_state (add_s[4]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_4_add_f_4(
    .sgn (add_sgn[4]),
    .provisional_exp (add_provisional_exp[4]),
    .provisional_frc (add_provisional_frc[4]),
    .sum_exp (add_e[4]),
    .sum_frc (add_f[4]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_5_add_provisional_exp_5_add_provisional_frc_5(
    .acc_s (acc_s[5]),
    .acc_e (acc_e[5]),
    .acc_f (acc_f[5]),
    .mul_s (mul_s[5]),
    .mul_e (mul_e[5]),
    .mul_f (mul_f[5]),
    .res_sgn (add_sgn[5]),
    .res_exp (add_provisional_exp[5]),
    .res_frc (add_provisional_frc[5]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_5(
    .lhs_s (acc_s[5]),
    .lhs_exp (acc_e[5]),
    .lhs_frac (acc_f[5][15:3]),
    .rhs_s (mul_s[5]),
    .rhs_exp (mul_e[5]),
    .rhs_frac (mul_f[5][15:3]),
    .iszero (add_zer[5]));

  mullin_addition_state mullin_addition_state_add_s_5(
    .acc_s (acc_s[5]),
    .mul_s (mul_s[5]),
    .sum_sgn (add_sgn[5]),
    .sum_zerocheck (add_zer[5]),
    .add_state (add_s[5]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_5_add_f_5(
    .sgn (add_sgn[5]),
    .provisional_exp (add_provisional_exp[5]),
    .provisional_frc (add_provisional_frc[5]),
    .sum_exp (add_e[5]),
    .sum_frc (add_f[5]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_6_add_provisional_exp_6_add_provisional_frc_6(
    .acc_s (acc_s[6]),
    .acc_e (acc_e[6]),
    .acc_f (acc_f[6]),
    .mul_s (mul_s[6]),
    .mul_e (mul_e[6]),
    .mul_f (mul_f[6]),
    .res_sgn (add_sgn[6]),
    .res_exp (add_provisional_exp[6]),
    .res_frc (add_provisional_frc[6]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_6(
    .lhs_s (acc_s[6]),
    .lhs_exp (acc_e[6]),
    .lhs_frac (acc_f[6][15:3]),
    .rhs_s (mul_s[6]),
    .rhs_exp (mul_e[6]),
    .rhs_frac (mul_f[6][15:3]),
    .iszero (add_zer[6]));

  mullin_addition_state mullin_addition_state_add_s_6(
    .acc_s (acc_s[6]),
    .mul_s (mul_s[6]),
    .sum_sgn (add_sgn[6]),
    .sum_zerocheck (add_zer[6]),
    .add_state (add_s[6]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_6_add_f_6(
    .sgn (add_sgn[6]),
    .provisional_exp (add_provisional_exp[6]),
    .provisional_frc (add_provisional_frc[6]),
    .sum_exp (add_e[6]),
    .sum_frc (add_f[6]));

  mullin_frc_add_16 mullin_frc_add_16_add_sgn_7_add_provisional_exp_7_add_provisional_frc_7(
    .acc_s (acc_s[7]),
    .acc_e (acc_e[7]),
    .acc_f (acc_f[7]),
    .mul_s (mul_s[7]),
    .mul_e (mul_e[7]),
    .mul_f (mul_f[7]),
    .res_sgn (add_sgn[7]),
    .res_exp (add_provisional_exp[7]),
    .res_frc (add_provisional_frc[7]));

  add_zero_checker_16bit add_zero_checker_16bit_add_zer_7(
    .lhs_s (acc_s[7]),
    .lhs_exp (acc_e[7]),
    .lhs_frac (acc_f[7][15:3]),
    .rhs_s (mul_s[7]),
    .rhs_exp (mul_e[7]),
    .rhs_frac (mul_f[7][15:3]),
    .iszero (add_zer[7]));

  mullin_addition_state mullin_addition_state_add_s_7(
    .acc_s (acc_s[7]),
    .mul_s (mul_s[7]),
    .sum_sgn (add_sgn[7]),
    .sum_zerocheck (add_zer[7]),
    .add_state (add_s[7]));

  mullin_addition_cleanup mullin_addition_cleanup_add_e_7_add_f_7(
    .sgn (add_sgn[7]),
    .provisional_exp (add_provisional_exp[7]),
    .provisional_frc (add_provisional_frc[7]),
    .sum_exp (add_e[7]),
    .sum_frc (add_f[7]));

  assign acc_s[0] = acc[23:21];
  assign ur_acc_e[0] = acc[20:16];
  assign ur_acc_f[0] = acc[15:0];
  assign mtx_s[0] = mtx[14:12];
  assign mtx_e[0] = mtx[11:8];
  assign mtx_f[0] = mtx[7:0];
  assign vec_s[0] = vec[14:12];
  assign vec_e[0] = vec[11:8];
  assign vec_f[0] = vec[7:0];
  assign acc_s[1] = acc[47:45];
  assign ur_acc_e[1] = acc[44:40];
  assign ur_acc_f[1] = acc[39:24];
  assign mtx_s[1] = mtx[29:27];
  assign mtx_e[1] = mtx[26:23];
  assign mtx_f[1] = mtx[22:15];
  assign vec_s[1] = vec[29:27];
  assign vec_e[1] = vec[26:23];
  assign vec_f[1] = vec[22:15];
  assign acc_s[2] = acc[71:69];
  assign ur_acc_e[2] = acc[68:64];
  assign ur_acc_f[2] = acc[63:48];
  assign mtx_s[2] = mtx[44:42];
  assign mtx_e[2] = mtx[41:38];
  assign mtx_f[2] = mtx[37:30];
  assign vec_s[2] = vec[44:42];
  assign vec_e[2] = vec[41:38];
  assign vec_f[2] = vec[37:30];
  assign acc_s[3] = acc[95:93];
  assign ur_acc_e[3] = acc[92:88];
  assign ur_acc_f[3] = acc[87:72];
  assign mtx_s[3] = mtx[59:57];
  assign mtx_e[3] = mtx[56:53];
  assign mtx_f[3] = mtx[52:45];
  assign vec_s[3] = vec[59:57];
  assign vec_e[3] = vec[56:53];
  assign vec_f[3] = vec[52:45];
  assign acc_s[4] = acc[119:117];
  assign ur_acc_e[4] = acc[116:112];
  assign ur_acc_f[4] = acc[111:96];
  assign mtx_s[4] = mtx[74:72];
  assign mtx_e[4] = mtx[71:68];
  assign mtx_f[4] = mtx[67:60];
  assign vec_s[4] = vec[74:72];
  assign vec_e[4] = vec[71:68];
  assign vec_f[4] = vec[67:60];
  assign acc_s[5] = acc[143:141];
  assign ur_acc_e[5] = acc[140:136];
  assign ur_acc_f[5] = acc[135:120];
  assign mtx_s[5] = mtx[89:87];
  assign mtx_e[5] = mtx[86:83];
  assign mtx_f[5] = mtx[82:75];
  assign vec_s[5] = vec[89:87];
  assign vec_e[5] = vec[86:83];
  assign vec_f[5] = vec[82:75];
  assign acc_s[6] = acc[167:165];
  assign ur_acc_e[6] = acc[164:160];
  assign ur_acc_f[6] = acc[159:144];
  assign mtx_s[6] = mtx[104:102];
  assign mtx_e[6] = mtx[101:98];
  assign mtx_f[6] = mtx[97:90];
  assign vec_s[6] = vec[104:102];
  assign vec_e[6] = vec[101:98];
  assign vec_f[6] = vec[97:90];
  assign acc_s[7] = acc[191:189];
  assign ur_acc_e[7] = acc[188:184];
  assign ur_acc_f[7] = acc[183:168];
  assign mtx_s[7] = mtx[119:117];
  assign mtx_e[7] = mtx[116:113];
  assign mtx_f[7] = mtx[112:105];
  assign vec_s[7] = vec[119:117];
  assign vec_e[7] = vec[116:113];
  assign vec_f[7] = vec[112:105];
  assign mul_raw_f[0] = (vec_f[0] * mtx_f[0]);
  assign mul_raw_f[1] = (vec_f[0] * mtx_f[1]);
  assign mul_raw_f[2] = (vec_f[0] * mtx_f[2]);
  assign mul_raw_f[3] = (vec_f[0] * mtx_f[3]);
  assign mul_raw_f[4] = (vec_f[0] * mtx_f[4]);
  assign mul_raw_f[5] = (vec_f[0] * mtx_f[5]);
  assign mul_raw_f[6] = (vec_f[0] * mtx_f[6]);
  assign mul_raw_f[7] = (vec_f[0] * mtx_f[7]);
  assign result_acc = {{add_s[7],add_e[7],add_f[7]},{add_s[6],add_e[6],add_f[6]},{add_s[5],add_e[5],add_f[5]},{add_s[4],add_e[4],add_f[4]},{add_s[3],add_e[3],add_f[3]},{add_s[2],add_e[2],add_f[2]},{add_s[1],add_e[1],add_f[1]},{add_s[0],add_e[0],add_f[0]}};
endmodule


module decode_posit_wrapper8(
  input [7:0] xposit,
  output [14:0] decoded_posit);

  wire [11:0] unrolled_posit;

  decode_posit_8bit decode_posit_8bit_unrolled_posit(
    .posit (xposit),
    .eposit (unrolled_posit));

  assign decoded_posit = {unrolled_posit,3'b000};
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


module mullin_frc_add_16(
  input [2:0] acc_s,
  input [4:0] acc_e,
  input [15:0] acc_f,
  input [2:0] mul_s,
  input [4:0] mul_e,
  input [15:0] mul_f,
  output res_sgn,
  output [4:0] res_exp,
  output [17:0] res_frc);

  wire [16:0] a_acc_f;
  wire [4:0] mul_dom_exp;
  wire [16:0] a_mul_f;
  wire [4:0] z_acc_e;
  wire acc_sgn;
  wire [16:0] z_mul_f;
  wire [17:0] mul_dom_frc;
  wire mul_zer;
  wire [4:0] acc_dom_exp;
  wire acc_wins;
  wire acc_zer;
  wire mul_wins;
  wire [17:0] acc_dom_frc;
  wire mul_sgn;
  wire [4:0] z_mul_e;
  wire [16:0] z_acc_f;

  mullin_add_augment_16 mullin_add_augment_16_a_acc_f(
    .sgn (acc_sgn),
    .frc (acc_f[15:2]),
    .augmented_frc (a_acc_f));

  mullin_add_augment_16 mullin_add_augment_16_a_mul_f(
    .sgn (mul_sgn),
    .frc (mul_f[15:2]),
    .augmented_frc (a_mul_f));

  add_theoretical_16p1bit add_theoretical_16p1bit_acc_wins_acc_dom_exp_acc_dom_frc(
    .dom_exp (z_acc_e),
    .dom_frac (z_acc_f),
    .sub_exp (z_mul_e),
    .sub_frac (z_mul_f),
    .fraction_win (acc_wins),
    .provisional_exp (acc_dom_exp),
    .provisional_frac (acc_dom_frc));

  add_theoretical_16p1bit add_theoretical_16p1bit_mul_wins_mul_dom_exp_mul_dom_frc(
    .dom_exp (z_mul_e),
    .dom_frac (z_mul_f),
    .sub_exp (z_acc_e),
    .sub_frac (z_acc_f),
    .fraction_win (mul_wins),
    .provisional_exp (mul_dom_exp),
    .provisional_frac (mul_dom_frc));

  assign acc_zer = acc_s[1];
  assign mul_zer = mul_s[1];
  assign acc_sgn = acc_s[0];
  assign mul_sgn = mul_s[0];
  assign z_acc_f = (a_acc_f & {17{~(acc_zer)}});
  assign z_mul_f = (a_mul_f & {17{~(mul_zer)}});
  assign z_acc_e = (acc_e & {5{~(acc_zer)}});
  assign z_mul_e = (mul_e & {5{~(mul_zer)}});
  assign res_sgn = (((acc_wins & acc_sgn) | (mul_wins & mul_sgn)) | (acc_sgn & mul_sgn));
  assign res_exp = (acc_dom_exp | mul_dom_exp);
  assign res_frc = (acc_dom_frc | mul_dom_frc);
endmodule


module round_accumulator__16bit(
  input [2:0] acc_s,
  input [4:0] ur_acc_e,
  input [15:0] ur_acc_f,
  output [4:0] acc_e,
  output [15:0] acc_f);

  wire neg_zero_exp;
  wire should_round;
  wire [4:0] exp_augment_value;
  wire augment_exp;

  assign should_round = ((ur_acc_f[2] & ur_acc_f[1]) | (ur_acc_f[1] & ur_acc_f[0]));
  assign acc_f = {(ur_acc_f[15:2] + 14'b00000000000000),2'b00};
  assign neg_zero_exp = ~(|(ur_acc_e));
  assign augment_exp = (~((|(acc_f) | neg_zero_exp)) & should_round);
  assign exp_augment_value = ({{4{acc_s[0]}},1'b1} & {5{augment_exp}});
  assign acc_e = (ur_acc_e + exp_augment_value);
endmodule


module mullin_mul_8_to_16bit(
  input [2:0] lhs_s,
  input [3:0] lhs_e,
  input [7:0] lhs_f,
  input [2:0] rhs_s,
  input [3:0] rhs_e,
  input [7:0] rhs_f,
  input [15:0] raw_m,
  output [2:0] prod_s,
  output [4:0] prod_exp,
  output [15:0] prod_frc);

  wire top_hidden_bit;
  wire lhs_inf;
  wire lhs_zer;
  wire rhs_zer;
  wire [6:0] lhs_sum_result;
  wire rhs_inf;
  wire [14:0] provisional_prod_frac;
  wire lhs_sgn;
  wire next_hidden_bit;
  wire rhs_sgn;
  wire [6:0] rhs_frac_lhs_sign;
  wire [1:0] frac_report;
  wire [6:0] extended_prod_exp;
  wire [12:0] prod_frc_short;
  wire [6:0] lhs_frac_rhs_sign;
  wire [11:0] full_sum_result;
  wire [17:0] general_mul_result;
  wire prod_sgn;
  wire [10:0] shifted_frac;

  mul_frac_hidden_crossmultiplier_8bit mul_frac_hidden_crossmultiplier_8bit_lhs_frac_rhs_sign(
    .crosssign (rhs_sgn),
    .frac (lhs_f[7:3]),
    .result (lhs_frac_rhs_sign));

  mul_frac_hidden_crossmultiplier_8bit mul_frac_hidden_crossmultiplier_8bit_rhs_frac_lhs_sign(
    .crosssign (lhs_sgn),
    .frac (rhs_f[7:3]),
    .result (rhs_frac_lhs_sign));

  mul_frac_finisher_bitsbit mul_frac_finisher_bitsbit_frac_report_shifted_frac(
    .final_sign (top_hidden_bit),
    .provisional_fraction (full_sum_result),
    .exponent_augment (frac_report),
    .shifted_fraction (shifted_frac));

  mul_frac_trimmer_11bit_to_16bit mul_frac_trimmer_11bit_to_16bit_provisional_prod_frac(
    .untrimmed_fraction (shifted_frac),
    .trimmed_frac (provisional_prod_frac));

  mul_exp_sum mul_exp_sum_extended_prod_exp(
    .prod_sign (prod_sgn),
    .lhs_exp (lhs_e),
    .rhs_exp (rhs_e),
    .frac_adjustment (frac_report),
    .adj_exp_sum (extended_prod_exp));

  exp_trim_16bit_mul exp_trim_16bit_mul_prod_exp_prod_frc_short(
    .sign (prod_sgn),
    .exp_untrimmed (extended_prod_exp),
    .frc_untrimmed (provisional_prod_frac),
    .exp_trimmed (prod_exp),
    .frc_out (prod_frc_short));

  assign lhs_sgn = lhs_s[0];
  assign rhs_sgn = rhs_s[0];
  assign lhs_zer = lhs_s[1];
  assign rhs_zer = rhs_s[1];
  assign lhs_inf = lhs_s[2];
  assign rhs_inf = rhs_s[2];
  assign top_hidden_bit = (lhs_sgn ^ rhs_sgn);
  assign next_hidden_bit = ~((lhs_sgn | rhs_sgn));
  assign general_mul_result = {top_hidden_bit,next_hidden_bit,raw_m};
  assign lhs_sum_result = (lhs_frac_rhs_sign + general_mul_result[17:11]);
  assign full_sum_result = {(rhs_frac_lhs_sign + lhs_sum_result),general_mul_result[10:6]};
  assign prod_sgn = (lhs_inf | rhs_inf);
  assign prod_s = {prod_sgn,(lhs_zer | rhs_zer),(lhs_sgn ^ rhs_sgn)};
  assign prod_frc = {prod_frc_short,3'b000};
endmodule


module mullin_addition_cleanup(
  input sgn,
  input [4:0] provisional_exp,
  input [17:0] provisional_frc,
  output [4:0] sum_exp,
  output [15:0] sum_frc);

  wire [5:0] sum_exp_diff;
  wire [15:0] frc_shift_onehot;
  wire [5:0] sum_exp_untrimmed;
  wire [13:0] sum_frc_trimmed;
  wire [1:0] sum_gs;
  wire [15:0] sum_frc_untrimmed;

  add_find_shift_onehot_16bit add_find_shift_onehot_16bit_frc_shift_onehot(
    .sign (sgn),
    .provisional_sum_frac (provisional_frc[17:1]),
    .leading_onehot (frc_shift_onehot));

  add_apply_shift_16bit add_apply_shift_16bit_sum_frc_untrimmed(
    .efraction (provisional_frc),
    .shift_onehot (frc_shift_onehot),
    .shifted_fraction (sum_frc_untrimmed));

  add_shift_diff_16bit add_shift_diff_16bit_sum_exp_diff(
    .shift_onehot (frc_shift_onehot),
    .exponent_delta (sum_exp_diff));

  add_exp_diff_16bit add_exp_diff_16bit_sum_exp_untrimmed(
    .old_exp (provisional_exp),
    .exp_delta (sum_exp_diff),
    .new_exp (sum_exp_untrimmed));

  exp_trim_16p1bit_add exp_trim_16p1bit_add_sum_exp_sum_frc_trimmed_sum_gs(
    .sign (sgn),
    .exp_untrimmed (sum_exp_untrimmed),
    .frc_untrimmed (sum_frc_untrimmed),
    .exp_trimmed (sum_exp),
    .frc_out (sum_frc_trimmed),
    .gs_bits (sum_gs));

  assign sum_frc = {sum_frc_trimmed,sum_gs};
endmodule


module mullin_addition_state(
  input [2:0] acc_s,
  input [2:0] mul_s,
  input sum_sgn,
  input sum_zerocheck,
  output [2:0] add_state);

  wire sum_nan;
  wire sum_zer;
  wire sum_inf;
  wire mul_zer;
  wire acc_inf;
  wire acc_zer;
  wire mul_inf;

  assign acc_inf = acc_s[2];
  assign mul_inf = mul_s[2];
  assign acc_zer = acc_s[1];
  assign mul_zer = mul_s[1];
  assign sum_inf = (acc_inf | mul_inf);
  assign sum_nan = ((acc_inf & mul_inf) | ((acc_inf & acc_zer) | (mul_inf & mul_zer)));
  assign sum_zer = (((acc_zer & mul_zer) | sum_zerocheck) | sum_nan);
  assign add_state = {sum_inf,sum_zer,sum_sgn};
endmodule


module add_zero_checker_16bit(
  input [2:0] lhs_s,
  input [4:0] lhs_exp,
  input [12:0] lhs_frac,
  input [2:0] rhs_s,
  input [4:0] rhs_exp,
  input [12:0] rhs_frac,
  output iszero);

  wire frac_match;
  wire lhs_zer;
  wire rhs_zer;
  wire lhs_sgn;
  wire rhs_sgn;
  wire [4:0] augmented_rhs;
  wire [4:0] augmented_lhs;
  wire exp_match;
  wire rhs_sgn_augment;
  wire lhs_sgn_augment;

  assign lhs_sgn = lhs_s[0];
  assign rhs_sgn = rhs_s[0];
  assign lhs_zer = lhs_s[1];
  assign rhs_zer = rhs_s[1];
  assign lhs_sgn_augment = (~(|(lhs_frac)) & lhs_sgn);
  assign rhs_sgn_augment = (~(|(rhs_frac)) & rhs_sgn);
  assign augmented_lhs = ({4'b0000,lhs_sgn_augment} + lhs_exp);
  assign augmented_rhs = ({4'b0000,rhs_sgn_augment} + rhs_exp);
  assign exp_match = ~(|((augmented_lhs ^ augmented_rhs)));
  assign frac_match = ~(|((lhs_frac + rhs_frac)));
  assign iszero = (((((lhs_sgn ^ rhs_sgn) & (exp_match & frac_match)) & ~(lhs_zer)) & ~(rhs_zer)) | (lhs_zer & rhs_zer));
endmodule


module add_apply_shift_16bit(
  input [17:0] efraction,
  input [15:0] shift_onehot,
  output [15:0] shifted_fraction);

  wire summary_lines;

  assign shifted_fraction[15] = |({(shift_onehot[0] & efraction[16]), (shift_onehot[1] & efraction[15]), (shift_onehot[2] & efraction[14]), (shift_onehot[3] & efraction[13]), (shift_onehot[4] & efraction[12]), (shift_onehot[5] & efraction[11]), (shift_onehot[6] & efraction[10]), (shift_onehot[7] & efraction[9]), (shift_onehot[8] & efraction[8]), (shift_onehot[9] & efraction[7]), (shift_onehot[10] & efraction[6]), (shift_onehot[11] & efraction[5]), (shift_onehot[12] & efraction[4]), (shift_onehot[13] & efraction[3]), (shift_onehot[14] & efraction[2]), (shift_onehot[15] & efraction[1])});
  assign shifted_fraction[14] = |({(shift_onehot[0] & efraction[15]), (shift_onehot[1] & efraction[14]), (shift_onehot[2] & efraction[13]), (shift_onehot[3] & efraction[12]), (shift_onehot[4] & efraction[11]), (shift_onehot[5] & efraction[10]), (shift_onehot[6] & efraction[9]), (shift_onehot[7] & efraction[8]), (shift_onehot[8] & efraction[7]), (shift_onehot[9] & efraction[6]), (shift_onehot[10] & efraction[5]), (shift_onehot[11] & efraction[4]), (shift_onehot[12] & efraction[3]), (shift_onehot[13] & efraction[2]), (shift_onehot[14] & efraction[1])});
  assign shifted_fraction[13] = |({(shift_onehot[0] & efraction[14]), (shift_onehot[1] & efraction[13]), (shift_onehot[2] & efraction[12]), (shift_onehot[3] & efraction[11]), (shift_onehot[4] & efraction[10]), (shift_onehot[5] & efraction[9]), (shift_onehot[6] & efraction[8]), (shift_onehot[7] & efraction[7]), (shift_onehot[8] & efraction[6]), (shift_onehot[9] & efraction[5]), (shift_onehot[10] & efraction[4]), (shift_onehot[11] & efraction[3]), (shift_onehot[12] & efraction[2]), (shift_onehot[13] & efraction[1])});
  assign shifted_fraction[12] = |({(shift_onehot[0] & efraction[13]), (shift_onehot[1] & efraction[12]), (shift_onehot[2] & efraction[11]), (shift_onehot[3] & efraction[10]), (shift_onehot[4] & efraction[9]), (shift_onehot[5] & efraction[8]), (shift_onehot[6] & efraction[7]), (shift_onehot[7] & efraction[6]), (shift_onehot[8] & efraction[5]), (shift_onehot[9] & efraction[4]), (shift_onehot[10] & efraction[3]), (shift_onehot[11] & efraction[2]), (shift_onehot[12] & efraction[1])});
  assign shifted_fraction[11] = |({(shift_onehot[0] & efraction[12]), (shift_onehot[1] & efraction[11]), (shift_onehot[2] & efraction[10]), (shift_onehot[3] & efraction[9]), (shift_onehot[4] & efraction[8]), (shift_onehot[5] & efraction[7]), (shift_onehot[6] & efraction[6]), (shift_onehot[7] & efraction[5]), (shift_onehot[8] & efraction[4]), (shift_onehot[9] & efraction[3]), (shift_onehot[10] & efraction[2]), (shift_onehot[11] & efraction[1])});
  assign shifted_fraction[10] = |({(shift_onehot[0] & efraction[11]), (shift_onehot[1] & efraction[10]), (shift_onehot[2] & efraction[9]), (shift_onehot[3] & efraction[8]), (shift_onehot[4] & efraction[7]), (shift_onehot[5] & efraction[6]), (shift_onehot[6] & efraction[5]), (shift_onehot[7] & efraction[4]), (shift_onehot[8] & efraction[3]), (shift_onehot[9] & efraction[2]), (shift_onehot[10] & efraction[1])});
  assign shifted_fraction[9] = |({(shift_onehot[0] & efraction[10]), (shift_onehot[1] & efraction[9]), (shift_onehot[2] & efraction[8]), (shift_onehot[3] & efraction[7]), (shift_onehot[4] & efraction[6]), (shift_onehot[5] & efraction[5]), (shift_onehot[6] & efraction[4]), (shift_onehot[7] & efraction[3]), (shift_onehot[8] & efraction[2]), (shift_onehot[9] & efraction[1])});
  assign shifted_fraction[8] = |({(shift_onehot[0] & efraction[9]), (shift_onehot[1] & efraction[8]), (shift_onehot[2] & efraction[7]), (shift_onehot[3] & efraction[6]), (shift_onehot[4] & efraction[5]), (shift_onehot[5] & efraction[4]), (shift_onehot[6] & efraction[3]), (shift_onehot[7] & efraction[2]), (shift_onehot[8] & efraction[1])});
  assign shifted_fraction[7] = |({(shift_onehot[0] & efraction[8]), (shift_onehot[1] & efraction[7]), (shift_onehot[2] & efraction[6]), (shift_onehot[3] & efraction[5]), (shift_onehot[4] & efraction[4]), (shift_onehot[5] & efraction[3]), (shift_onehot[6] & efraction[2]), (shift_onehot[7] & efraction[1])});
  assign shifted_fraction[6] = |({(shift_onehot[0] & efraction[7]), (shift_onehot[1] & efraction[6]), (shift_onehot[2] & efraction[5]), (shift_onehot[3] & efraction[4]), (shift_onehot[4] & efraction[3]), (shift_onehot[5] & efraction[2]), (shift_onehot[6] & efraction[1])});
  assign shifted_fraction[5] = |({(shift_onehot[0] & efraction[6]), (shift_onehot[1] & efraction[5]), (shift_onehot[2] & efraction[4]), (shift_onehot[3] & efraction[3]), (shift_onehot[4] & efraction[2]), (shift_onehot[5] & efraction[1])});
  assign shifted_fraction[4] = |({(shift_onehot[0] & efraction[5]), (shift_onehot[1] & efraction[4]), (shift_onehot[2] & efraction[3]), (shift_onehot[3] & efraction[2]), (shift_onehot[4] & efraction[1])});
  assign shifted_fraction[3] = |({(shift_onehot[0] & efraction[4]), (shift_onehot[1] & efraction[3]), (shift_onehot[2] & efraction[2]), (shift_onehot[3] & efraction[1])});
  assign shifted_fraction[2] = |({(shift_onehot[0] & efraction[3]), (shift_onehot[1] & efraction[2]), (shift_onehot[2] & efraction[1])});
  assign shifted_fraction[1] = |({(shift_onehot[0] & efraction[2]), (shift_onehot[1] & efraction[1]), (shift_onehot[2] & efraction[0])});
  assign summary_lines = (((efraction[1] | efraction[0]) & shift_onehot[0]) | (efraction[0] & shift_onehot[1]));
  assign shifted_fraction[0] = summary_lines;
endmodule


module add_find_shift_onehot_16bit(
  input sign,
  input [16:0] provisional_sum_frac,
  output [15:0] leading_onehot);

  wire [16:0] sumvalue;

  assign sumvalue = (provisional_sum_frac ^ {17{sign}});
  assign leading_onehot[0] = sumvalue[16];
  assign leading_onehot[1] = (~({sumvalue[16]}) & sumvalue[15]);
  assign leading_onehot[2] = (~(|({sumvalue[16],sumvalue[15]})) & sumvalue[14]);
  assign leading_onehot[3] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14]})) & sumvalue[13]);
  assign leading_onehot[4] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13]})) & sumvalue[12]);
  assign leading_onehot[5] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12]})) & sumvalue[11]);
  assign leading_onehot[6] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11]})) & sumvalue[10]);
  assign leading_onehot[7] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10]})) & sumvalue[9]);
  assign leading_onehot[8] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9]})) & sumvalue[8]);
  assign leading_onehot[9] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8]})) & sumvalue[7]);
  assign leading_onehot[10] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7]})) & sumvalue[6]);
  assign leading_onehot[11] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7],sumvalue[6]})) & sumvalue[5]);
  assign leading_onehot[12] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5]})) & sumvalue[4]);
  assign leading_onehot[13] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4]})) & sumvalue[3]);
  assign leading_onehot[14] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4],sumvalue[3]})) & sumvalue[2]);
  assign leading_onehot[15] = (~(|({sumvalue[16],sumvalue[15],sumvalue[14],sumvalue[13],sumvalue[12],sumvalue[11],sumvalue[10],sumvalue[9],sumvalue[8],sumvalue[7],sumvalue[6],sumvalue[5],sumvalue[4],sumvalue[3],sumvalue[2]})) & sumvalue[1]);
endmodule


module add_shift_diff_16bit(
  input [15:0] shift_onehot,
  output [5:0] exponent_delta);

  assign exponent_delta[0] = |({shift_onehot[0],shift_onehot[2],shift_onehot[4],shift_onehot[6],shift_onehot[8],shift_onehot[10],shift_onehot[12],shift_onehot[14]});
  assign exponent_delta[1] = |({shift_onehot[2],shift_onehot[3],shift_onehot[6],shift_onehot[7],shift_onehot[10],shift_onehot[11],shift_onehot[14],shift_onehot[15]});
  assign exponent_delta[2] = |({shift_onehot[2],shift_onehot[3],shift_onehot[4],shift_onehot[5],shift_onehot[10],shift_onehot[11],shift_onehot[12],shift_onehot[13]});
  assign exponent_delta[3] = |({shift_onehot[2],shift_onehot[3],shift_onehot[4],shift_onehot[5],shift_onehot[6],shift_onehot[7],shift_onehot[8],shift_onehot[9]});
  assign exponent_delta[4] = |({shift_onehot[2],shift_onehot[3],shift_onehot[4],shift_onehot[5],shift_onehot[6],shift_onehot[7],shift_onehot[8],shift_onehot[9],shift_onehot[10],shift_onehot[11],shift_onehot[12],shift_onehot[13],shift_onehot[14],shift_onehot[15]});
  assign exponent_delta[5] = ~((shift_onehot[0] | shift_onehot[1]));
endmodule


module add_exp_diff_16bit(
  input [4:0] old_exp,
  input [5:0] exp_delta,
  output [5:0] new_exp);

  assign new_exp = ({1'b0,old_exp} + exp_delta);
endmodule


module exp_trim_16p1bit_add(
  input sign,
  input [5:0] exp_untrimmed,
  input [15:0] frc_untrimmed,
  output [4:0] exp_trimmed,
  output [13:0] frc_out,
  output [1:0] gs_bits);

  wire do_exp_clipping;
  wire [5:0] positive_limit_exp;
  wire [4:0] clipping_value;
  wire [15:0] frc_trimmed;
  wire overflowed;
  wire [5:0] negative_limit_exp;
  wire underflowed;

  assign positive_limit_exp = 6'b011101;
  assign negative_limit_exp = 6'b011100;
  assign underflowed = (exp_untrimmed[5] | (~(sign) & ~(|(exp_untrimmed))));
  assign overflowed = (((~(exp_untrimmed[5]) & ~(sign)) & (exp_untrimmed > positive_limit_exp)) | ((~(exp_untrimmed[5]) & sign) & (exp_untrimmed > negative_limit_exp)));
  assign clipping_value[4:1] = ({4'b1110} & {4{overflowed}});
  assign clipping_value[0] = ~(sign);
  assign do_exp_clipping = (underflowed | overflowed);
  assign exp_trimmed = ((exp_untrimmed[4:0] & {5{~(do_exp_clipping)}}) | (clipping_value & {5{do_exp_clipping}}));
  assign frc_trimmed = ((frc_untrimmed[15:0] & {16{(~((overflowed | underflowed)) | (overflowed ^ sign))}}) | {16{((overflowed | underflowed) & (overflowed ^ sign))}});
  assign gs_bits = frc_trimmed[1:0];
  assign frc_out = frc_trimmed[15:2];
endmodule


module mul_frac_trimmer_11bit_to_16bit(
  input [10:0] untrimmed_fraction,
  output [14:0] trimmed_frac);

  wire summ_val;
  wire [12:0] frac_val;
  wire guard_val;

  assign frac_val = {untrimmed_fraction,2'b00};
  assign guard_val = 1'b0;
  assign summ_val = 1'b0;
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


module exp_trim_16bit_mul(
  input sign,
  input [6:0] exp_untrimmed,
  input [14:0] frc_untrimmed,
  output [4:0] exp_trimmed,
  output [12:0] frc_out,
  output [1:0] gs_bits);

  wire do_exp_clipping;
  wire [6:0] positive_limit_exp;
  wire [4:0] clipping_value;
  wire [14:0] frc_trimmed;
  wire overflowed;
  wire [6:0] negative_limit_exp;
  wire underflowed;

  assign positive_limit_exp = 7'b0011101;
  assign negative_limit_exp = 7'b0011100;
  assign underflowed = (exp_untrimmed[6] | (~(sign) & ~(|(exp_untrimmed))));
  assign overflowed = (((~(exp_untrimmed[6]) & ~(sign)) & (exp_untrimmed > positive_limit_exp)) | ((~(exp_untrimmed[6]) & sign) & (exp_untrimmed > negative_limit_exp)));
  assign clipping_value[4:1] = ({4'b1110} & {4{overflowed}});
  assign clipping_value[0] = ~(sign);
  assign do_exp_clipping = (underflowed | overflowed);
  assign exp_trimmed = ((exp_untrimmed[4:0] & {5{~(do_exp_clipping)}}) | (clipping_value & {5{do_exp_clipping}}));
  assign frc_trimmed = ((frc_untrimmed[14:0] & {15{(~((overflowed | underflowed)) | (overflowed ^ sign))}}) | {15{((overflowed | underflowed) & (overflowed ^ sign))}});
  assign gs_bits = frc_trimmed[1:0];
  assign frc_out = frc_trimmed[14:2];
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


module mul_exp_sum(
  input prod_sign,
  input [3:0] lhs_exp,
  input [3:0] rhs_exp,
  input [1:0] frac_adjustment,
  output [6:0] adj_exp_sum);

  wire [6:0] dual_exp_sum;
  wire [6:0] lhs_exp_sum;
  wire [6:0] bias_wire;

  assign bias_wire = 7'b0000001;
  assign lhs_exp_sum = (bias_wire + {3'b000,lhs_exp});
  assign dual_exp_sum = (lhs_exp_sum + {3'b000,rhs_exp});
  assign adj_exp_sum = (dual_exp_sum + {5'b00000,frac_adjustment});
endmodule


module add_theoretical_16p1bit(
  input [4:0] dom_exp,
  input [16:0] dom_frac,
  input [4:0] sub_exp,
  input [16:0] sub_frac,
  output fraction_win,
  output [4:0] provisional_exp,
  output [17:0] provisional_frac);

  wire [17:0] shft_sub_frac;
  wire [5:0] sum_exp;
  wire nuke_me;
  wire [5:0] esub_exp;
  wire [5:0] edom_exp;
  wire [4:0] shift;
  wire [17:0] sum_frac;

  add_rightshift_16p1bit add_rightshift_16p1bit_shft_sub_frac(
    .fraction (sub_frac),
    .shift (shift),
    .frac_rs (shft_sub_frac));

  assign edom_exp = {1'b0,dom_exp};
  assign esub_exp = {1'b0,sub_exp};
  assign sum_exp = (edom_exp - esub_exp);
  assign nuke_me = sum_exp[5];
  assign shift = sum_exp[4:0];
  assign sum_frac = ({dom_frac,1'b0} + shft_sub_frac);
  assign fraction_win = ~(((dom_frac[16] ^ sum_frac[17]) | nuke_me));
  assign provisional_exp = (dom_exp & {5{~(nuke_me)}});
  assign provisional_frac = ({sum_frac} & {18{~(nuke_me)}});
endmodule


module mullin_add_augment_16(
  input sgn,
  input [13:0] frc,
  output [16:0] augmented_frc);

  assign augmented_frc = {sgn,~(sgn),frc,1'b0};
endmodule


module add_rightshift_16p1bit(
  input [16:0] fraction,
  input [4:0] shift,
  output [17:0] frac_rs);

  wire [15:1] summary;
  wire [16:0] rightshifted_frac;
  wire summary_bit;

  assign rightshifted_frac = ($signed(fraction) >>> shift);
  assign summary[1] = (fraction[0] & (shift == 5'b00001));
  assign summary[2] = (|(fraction[1:0]) & (shift == 5'b00010));
  assign summary[3] = (|(fraction[2:0]) & (shift == 5'b00011));
  assign summary[4] = (|(fraction[3:0]) & (shift == 5'b00100));
  assign summary[5] = (|(fraction[4:0]) & (shift == 5'b00101));
  assign summary[6] = (|(fraction[5:0]) & (shift == 5'b00110));
  assign summary[7] = (|(fraction[6:0]) & (shift == 5'b00111));
  assign summary[8] = (|(fraction[7:0]) & (shift == 5'b01000));
  assign summary[9] = (|(fraction[8:0]) & (shift == 5'b01001));
  assign summary[10] = (|(fraction[9:0]) & (shift == 5'b01010));
  assign summary[11] = (|(fraction[10:0]) & (shift == 5'b01011));
  assign summary[12] = (|(fraction[11:0]) & (shift == 5'b01100));
  assign summary[13] = (|(fraction[12:0]) & (shift == 5'b01101));
  assign summary[14] = (|(fraction[13:0]) & (shift == 5'b01110));
  assign summary[15] = (|(fraction[14:0]) & (shift == 5'b01111));
  assign summary_bit = (shift[4] | |(summary));
  assign frac_rs = {rightshifted_frac,summary_bit};
endmodule


module encode_posit_16bit(
  input p_inf,
  input p_zer,
  input p_sgn,
  input [4:0] p_exp,
  input [12:0] p_frc,
  input [1:0] p_gs,
  output [15:0] posit);

  wire [4:0] shift_bin;
  wire [14:0] regime_onehot;
  wire [16:0] shifted_frac_gs;
  wire [16:0] efrac_gs;
  wire [14:0] efrac_src;

  enc_shift_bin_16bit enc_shift_bin_16bit_shift_bin(
    .regime (p_exp),
    .shift_bin (shift_bin));

  enc_regime_onehot_16bit enc_regime_onehot_16bit_regime_onehot(
    .shift_bin (shift_bin[3:0]),
    .regime_onehot (regime_onehot));

  enc_efrac_16bit enc_efrac_16bit_efrac_gs(
    .sign (p_sgn),
    .inv (shift_bin[4]),
    .frac (efrac_src),
    .efrac_gs (efrac_gs));

  enc_shifted_frac_gs_16bit enc_shifted_frac_gs_16bit_shifted_frac_gs(
    .one_hot (regime_onehot),
    .ext_frac (efrac_gs),
    .shifted_frac (shifted_frac_gs));

  enc_finalizer_16bit enc_finalizer_16bit_posit(
    .inf (p_inf),
    .zero (p_zer),
    .sign (p_sgn),
    .shifted_frac_gs (shifted_frac_gs),
    .posit (posit));

  assign efrac_src = {p_frc,p_gs};
endmodule


module enc_finalizer_16bit(
  input inf,
  input zero,
  input sign,
  input [16:0] shifted_frac_gs,
  output [15:0] posit);

  wire [15:0] provisional_posit;
  wire rounded_flag;
  wire [14:0] rounded_value;
  wire infzero;

  assign rounded_flag = ((shifted_frac_gs[0] & shifted_frac_gs[1]) | (shifted_frac_gs[1] & shifted_frac_gs[2]));
  assign rounded_value = (shifted_frac_gs[16:2] + {14'b00000000000000,rounded_flag});
  assign provisional_posit = {sign,rounded_value};
  assign infzero = (inf | zero);
  assign posit = (({16{infzero}} & {inf,15'b000000000000000}) | ({16{~(infzero)}} & provisional_posit));
endmodule


module enc_shifted_frac_gs_16bit(
  input [14:0] one_hot,
  input [16:0] ext_frac,
  output [16:0] shifted_frac);

  wire [14:0] summary_accumulator;

  assign summary_accumulator[0] = (one_hot[0] & ext_frac[0]);
  assign summary_accumulator[1] = (one_hot[1] & |(ext_frac[1:0]));
  assign summary_accumulator[2] = (one_hot[2] & |(ext_frac[2:0]));
  assign summary_accumulator[3] = (one_hot[3] & |(ext_frac[3:0]));
  assign summary_accumulator[4] = (one_hot[4] & |(ext_frac[4:0]));
  assign summary_accumulator[5] = (one_hot[5] & |(ext_frac[5:0]));
  assign summary_accumulator[6] = (one_hot[6] & |(ext_frac[6:0]));
  assign summary_accumulator[7] = (one_hot[7] & |(ext_frac[7:0]));
  assign summary_accumulator[8] = (one_hot[8] & |(ext_frac[8:0]));
  assign summary_accumulator[9] = (one_hot[9] & |(ext_frac[9:0]));
  assign summary_accumulator[10] = (one_hot[10] & |(ext_frac[10:0]));
  assign summary_accumulator[11] = (one_hot[11] & |(ext_frac[11:0]));
  assign summary_accumulator[12] = (one_hot[12] & |(ext_frac[12:0]));
  assign summary_accumulator[13] = (one_hot[13] & |(ext_frac[13:0]));
  assign summary_accumulator[14] = (one_hot[14] & |(ext_frac[14:0]));
  assign shifted_frac[0] = |(summary_accumulator);
  assign shifted_frac[1] = |((one_hot[14:0] & ext_frac[15:1]));
  assign shifted_frac[2] = |({(one_hot[13:0] & ext_frac[15:2]),(one_hot[14] & ext_frac[16])});
  assign shifted_frac[3] = |({(one_hot[12:0] & ext_frac[15:3]),(|(one_hot[14:13]) & ext_frac[16])});
  assign shifted_frac[4] = |({(one_hot[11:0] & ext_frac[15:4]),(|(one_hot[14:12]) & ext_frac[16])});
  assign shifted_frac[5] = |({(one_hot[10:0] & ext_frac[15:5]),(|(one_hot[14:11]) & ext_frac[16])});
  assign shifted_frac[6] = |({(one_hot[9:0] & ext_frac[15:6]),(|(one_hot[14:10]) & ext_frac[16])});
  assign shifted_frac[7] = |({(one_hot[8:0] & ext_frac[15:7]),(|(one_hot[14:9]) & ext_frac[16])});
  assign shifted_frac[8] = |({(one_hot[7:0] & ext_frac[15:8]),(|(one_hot[14:8]) & ext_frac[16])});
  assign shifted_frac[9] = |({(one_hot[6:0] & ext_frac[15:9]),(|(one_hot[14:7]) & ext_frac[16])});
  assign shifted_frac[10] = |({(one_hot[5:0] & ext_frac[15:10]),(|(one_hot[14:6]) & ext_frac[16])});
  assign shifted_frac[11] = |({(one_hot[4:0] & ext_frac[15:11]),(|(one_hot[14:5]) & ext_frac[16])});
  assign shifted_frac[12] = |({(one_hot[3:0] & ext_frac[15:12]),(|(one_hot[14:4]) & ext_frac[16])});
  assign shifted_frac[13] = |({(one_hot[2:0] & ext_frac[15:13]),(|(one_hot[14:3]) & ext_frac[16])});
  assign shifted_frac[14] = |({(one_hot[1:0] & ext_frac[15:14]),(|(one_hot[14:2]) & ext_frac[16])});
  assign shifted_frac[15] = |({(one_hot[0] & ext_frac[15]),(|(one_hot[14:1]) & ext_frac[16])});
  assign shifted_frac[16] = (|(one_hot) & ext_frac[16]);
endmodule


module enc_regime_onehot_16bit(
  input [3:0] shift_bin,
  output [14:0] regime_onehot);

  wire [3:0] neg_shift_bin;

  assign neg_shift_bin = ~(shift_bin);
  assign regime_onehot[0] = &({neg_shift_bin[0], neg_shift_bin[1], neg_shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[1] = &({shift_bin[0], neg_shift_bin[1], neg_shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[2] = &({neg_shift_bin[0], shift_bin[1], neg_shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[3] = &({shift_bin[0], shift_bin[1], neg_shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[4] = &({neg_shift_bin[0], neg_shift_bin[1], shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[5] = &({shift_bin[0], neg_shift_bin[1], shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[6] = &({neg_shift_bin[0], shift_bin[1], shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[7] = &({shift_bin[0], shift_bin[1], shift_bin[2], neg_shift_bin[3]});
  assign regime_onehot[8] = &({neg_shift_bin[0], neg_shift_bin[1], neg_shift_bin[2], shift_bin[3]});
  assign regime_onehot[9] = &({shift_bin[0], neg_shift_bin[1], neg_shift_bin[2], shift_bin[3]});
  assign regime_onehot[10] = &({neg_shift_bin[0], shift_bin[1], neg_shift_bin[2], shift_bin[3]});
  assign regime_onehot[11] = &({shift_bin[0], shift_bin[1], neg_shift_bin[2], shift_bin[3]});
  assign regime_onehot[12] = &({neg_shift_bin[0], neg_shift_bin[1], shift_bin[2], shift_bin[3]});
  assign regime_onehot[13] = &({shift_bin[0], neg_shift_bin[1], shift_bin[2], shift_bin[3]});
  assign regime_onehot[14] = &({neg_shift_bin[0], shift_bin[1], shift_bin[2], shift_bin[3]});
endmodule


module enc_shift_bin_16bit(
  input [4:0] regime,
  output [4:0] shift_bin);

  wire regime_sign;
  wire [3:0] inv_signed_regime;
  wire [4:0] regime_subtrahend;
  wire [4:0] signed_regime;

  assign regime_subtrahend = 5'b01111;
  assign signed_regime = (regime - regime_subtrahend);
  assign inv_signed_regime = (-(signed_regime[3:0]) - 4'b0001);
  assign regime_sign = signed_regime[4];
  assign shift_bin = {signed_regime[4],(({4{regime_sign}} & inv_signed_regime) | ({4{~(regime_sign)}} & signed_regime[3:0]))};
endmodule


module enc_efrac_16bit(
  input sign,
  input inv,
  input [14:0] frac,
  output [16:0] efrac_gs);

  wire [1:0] leading_bits;

  assign leading_bits = {^({sign,inv}), ~^({sign,inv})};
  assign efrac_gs = {leading_bits[0],leading_bits[1],frac};
endmodule


module decode_posit_16bit(
  input [15:0] posit,
  output [20:0] eposit);

  wire allzeros;
  wire [14:0] shift_onehot;
  wire [1:0] infzeroflags;
  wire [12:0] expfrac_bits;
  wire [4:0] regime_bits;

  dec_inf_zero_bits dec_inf_zero_bits_infzeroflags(
    .signbit (posit[15]),
    .allzeros (allzeros),
    .result (infzeroflags));

  dec_shift_onehot_16bit dec_shift_onehot_16bit_shift_onehot(
    .posit (posit),
    .shift_onehot (shift_onehot));

  dec_expfrac_16bit dec_expfrac_16bit_expfrac_bits(
    .posit (posit),
    .shift_onehot (shift_onehot),
    .expfrac (expfrac_bits));

  dec_regime_16bit dec_regime_16bit_regime_bits(
    .signinv (posit[15:14]),
    .shift_onehot (shift_onehot),
    .regime (regime_bits));

  assign allzeros = ~(|(posit[14:0]));
  assign eposit = {infzeroflags,posit[15],regime_bits,expfrac_bits};
endmodule


module dec_expfrac_16bit(
  input [15:0] posit,
  input [14:0] shift_onehot,
  output [12:0] expfrac);

  assign expfrac[0] = (shift_onehot[0] & posit[0]);
  assign expfrac[1] = |(({shift_onehot[0], shift_onehot[1]} & posit[1:0]));
  assign expfrac[2] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2]} & posit[2:0]));
  assign expfrac[3] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3]} & posit[3:0]));
  assign expfrac[4] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4]} & posit[4:0]));
  assign expfrac[5] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5]} & posit[5:0]));
  assign expfrac[6] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6]} & posit[6:0]));
  assign expfrac[7] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7]} & posit[7:0]));
  assign expfrac[8] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8]} & posit[8:0]));
  assign expfrac[9] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8], shift_onehot[9]} & posit[9:0]));
  assign expfrac[10] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8], shift_onehot[9], shift_onehot[10]} & posit[10:0]));
  assign expfrac[11] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8], shift_onehot[9], shift_onehot[10], shift_onehot[11]} & posit[11:0]));
  assign expfrac[12] = |(({shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8], shift_onehot[9], shift_onehot[10], shift_onehot[11], shift_onehot[12]} & posit[12:0]));
endmodule


module dec_regime_16bit(
  input [1:0] signinv,
  input [14:0] shift_onehot,
  output [4:0] regime);

  wire [1:0] inv_rails;
  wire [29:1] regime_onehot;

  dec_regime_onehot_16bit dec_regime_onehot_16bit_regime_onehot(
    .inv_rails (inv_rails),
    .shift_onehot (shift_onehot),
    .regime_onehot (regime_onehot));

  dec_regime_bin_16bit dec_regime_bin_16bit_regime(
    .one_hot_regime (regime_onehot),
    .regime_bin (regime));

  assign inv_rails = {^(signinv), ~^(signinv)};
endmodule


module dec_shift_onehot_16bit(
  input [15:0] posit,
  output [14:0] shift_onehot);

  wire [13:0] xnorlines;
  wire [13:0] xorlines;

  assign xorlines = (posit[13:0] ^ {14{posit[14]}});
  assign xnorlines = ~(xorlines);
  assign shift_onehot[0] = xorlines[13];
  assign shift_onehot[1] = &({xorlines[12],xnorlines[13]});
  assign shift_onehot[2] = &({xorlines[11],xnorlines[13:12]});
  assign shift_onehot[3] = &({xorlines[10],xnorlines[13:11]});
  assign shift_onehot[4] = &({xorlines[9],xnorlines[13:10]});
  assign shift_onehot[5] = &({xorlines[8],xnorlines[13:9]});
  assign shift_onehot[6] = &({xorlines[7],xnorlines[13:8]});
  assign shift_onehot[7] = &({xorlines[6],xnorlines[13:7]});
  assign shift_onehot[8] = &({xorlines[5],xnorlines[13:6]});
  assign shift_onehot[9] = &({xorlines[4],xnorlines[13:5]});
  assign shift_onehot[10] = &({xorlines[3],xnorlines[13:4]});
  assign shift_onehot[11] = &({xorlines[2],xnorlines[13:3]});
  assign shift_onehot[12] = &({xorlines[1],xnorlines[13:2]});
  assign shift_onehot[13] = &({xorlines[0],xnorlines[13:1]});
  assign shift_onehot[14] = &(xnorlines[13:0]);
endmodule


module dec_regime_onehot_16bit(
  input [1:0] inv_rails,
  input [14:0] shift_onehot,
  output [29:1] regime_onehot);

  assign regime_onehot[14:1] = ({14{inv_rails[0]}} & {shift_onehot[0], shift_onehot[1], shift_onehot[2], shift_onehot[3], shift_onehot[4], shift_onehot[5], shift_onehot[6], shift_onehot[7], shift_onehot[8], shift_onehot[9], shift_onehot[10], shift_onehot[11], shift_onehot[12], shift_onehot[13]});
  assign regime_onehot[29:15] = ({15{inv_rails[1]}} & shift_onehot[14:0]);
endmodule


module dec_regime_bin_16bit(
  input [29:1] one_hot_regime,
  output [4:0] regime_bin);

  assign regime_bin[0] = |({one_hot_regime[1], one_hot_regime[3], one_hot_regime[5], one_hot_regime[7], one_hot_regime[9], one_hot_regime[11], one_hot_regime[13], one_hot_regime[15], one_hot_regime[17], one_hot_regime[19], one_hot_regime[21], one_hot_regime[23], one_hot_regime[25], one_hot_regime[27], one_hot_regime[29]});
  assign regime_bin[1] = |({one_hot_regime[2], one_hot_regime[3], one_hot_regime[6], one_hot_regime[7], one_hot_regime[10], one_hot_regime[11], one_hot_regime[14], one_hot_regime[15], one_hot_regime[18], one_hot_regime[19], one_hot_regime[22], one_hot_regime[23], one_hot_regime[26], one_hot_regime[27]});
  assign regime_bin[2] = |({one_hot_regime[4], one_hot_regime[5], one_hot_regime[6], one_hot_regime[7], one_hot_regime[12], one_hot_regime[13], one_hot_regime[14], one_hot_regime[15], one_hot_regime[20], one_hot_regime[21], one_hot_regime[22], one_hot_regime[23], one_hot_regime[28], one_hot_regime[29]});
  assign regime_bin[3] = |({one_hot_regime[8], one_hot_regime[9], one_hot_regime[10], one_hot_regime[11], one_hot_regime[12], one_hot_regime[13], one_hot_regime[14], one_hot_regime[15], one_hot_regime[24], one_hot_regime[25], one_hot_regime[26], one_hot_regime[27], one_hot_regime[28], one_hot_regime[29]});
  assign regime_bin[4] = |({one_hot_regime[16], one_hot_regime[17], one_hot_regime[18], one_hot_regime[19], one_hot_regime[20], one_hot_regime[21], one_hot_regime[22], one_hot_regime[23], one_hot_regime[24], one_hot_regime[25], one_hot_regime[26], one_hot_regime[27], one_hot_regime[28], one_hot_regime[29]});
endmodule

module mullin_8row_c_wrapper(
  input [63:0] acc_msb,
  input [63:0] acc_lsb,
  input [63:0] vec_a,
  input [63:0] mtx_0,
  input [63:0] mtx_1,
  input [63:0] mtx_2,
  input [63:0] mtx_3,
  input [63:0] mtx_4,
  input [63:0] mtx_5,
  input [63:0] mtx_6,
  input [63:0] mtx_7,
  output [63:0] res_msb,
  output [63:0] res_lsb);

  wire [119:0] vec;
  wire [23:0] initial_accumulators[7:0];
  wire [14:0] col7_vector[7:0];
  wire [191:0] acc_1;
  wire [14:0] col2_vector[7:0];
  wire [14:0] col3_vector[7:0];
  wire [191:0] acc_5;
  wire [119:0] col_1;
  wire [119:0] col_3;
  wire [119:0] col_4;
  wire [119:0] col_0;
  wire [191:0] acc_2;
  wire [191:0] acc_7;
  wire [119:0] col_7;
  wire [14:0] col5_vector[7:0];
  wire [15:0] res_wires[7:0];
  wire [14:0] col0_vector[7:0];
  wire [119:0] col_5;
  wire [14:0] col1_vector[7:0];
  wire [191:0] acc_0;
  wire [191:0] acc_3;
  wire [191:0] acc_4;
  wire [191:0] acc_6;
  wire [119:0] col_6;
  wire [14:0] col6_vector[7:0];
  wire [14:0] col4_vector[7:0];
  wire [191:0] acc_8;
  wire [119:0] col_2;
  wire [14:0] initial_vector[7:0];

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_0(
    .xposit (acc_lsb[15:0]),
    .decoded_posit (initial_accumulators[0]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_1(
    .xposit (acc_lsb[31:16]),
    .decoded_posit (initial_accumulators[1]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_2(
    .xposit (acc_lsb[47:32]),
    .decoded_posit (initial_accumulators[2]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_3(
    .xposit (acc_lsb[63:48]),
    .decoded_posit (initial_accumulators[3]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_4(
    .xposit (acc_msb[15:0]),
    .decoded_posit (initial_accumulators[4]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_5(
    .xposit (acc_msb[31:16]),
    .decoded_posit (initial_accumulators[5]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_6(
    .xposit (acc_msb[47:32]),
    .decoded_posit (initial_accumulators[6]));

  decode_posit_wrapper16 decode_posit_wrapper16_initial_accumulators_7(
    .xposit (acc_msb[63:48]),
    .decoded_posit (initial_accumulators[7]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_7(
    .xposit (vec_a[7:0]),
    .decoded_posit (initial_vector[7]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_6(
    .xposit (vec_a[15:8]),
    .decoded_posit (initial_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_5(
    .xposit (vec_a[23:16]),
    .decoded_posit (initial_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_4(
    .xposit (vec_a[31:24]),
    .decoded_posit (initial_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_3(
    .xposit (vec_a[39:32]),
    .decoded_posit (initial_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_2(
    .xposit (vec_a[47:40]),
    .decoded_posit (initial_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_1(
    .xposit (vec_a[55:48]),
    .decoded_posit (initial_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_initial_vector_0(
    .xposit (vec_a[63:56]),
    .decoded_posit (initial_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_0(
    .xposit (mtx_0[7:0]),
    .decoded_posit (col0_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_1(
    .xposit (mtx_0[15:8]),
    .decoded_posit (col0_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_2(
    .xposit (mtx_0[23:16]),
    .decoded_posit (col0_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_3(
    .xposit (mtx_0[31:24]),
    .decoded_posit (col0_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_4(
    .xposit (mtx_0[39:32]),
    .decoded_posit (col0_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_5(
    .xposit (mtx_0[47:40]),
    .decoded_posit (col0_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_6(
    .xposit (mtx_0[55:48]),
    .decoded_posit (col0_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col0_vector_7(
    .xposit (mtx_0[63:56]),
    .decoded_posit (col0_vector[7]));

  mullinrow_1 mullinrow_1_acc_1(
    .vec (vec),
    .acc (acc_0),
    .mtx (col_0),
    .result_acc (acc_1));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_0(
    .xposit (mtx_1[7:0]),
    .decoded_posit (col1_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_1(
    .xposit (mtx_1[15:8]),
    .decoded_posit (col1_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_2(
    .xposit (mtx_1[23:16]),
    .decoded_posit (col1_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_3(
    .xposit (mtx_1[31:24]),
    .decoded_posit (col1_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_4(
    .xposit (mtx_1[39:32]),
    .decoded_posit (col1_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_5(
    .xposit (mtx_1[47:40]),
    .decoded_posit (col1_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_6(
    .xposit (mtx_1[55:48]),
    .decoded_posit (col1_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col1_vector_7(
    .xposit (mtx_1[63:56]),
    .decoded_posit (col1_vector[7]));

  mullinrow_2 mullinrow_2_acc_2(
    .vec (vec),
    .acc (acc_1),
    .mtx (col_1),
    .result_acc (acc_2));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_0(
    .xposit (mtx_2[7:0]),
    .decoded_posit (col2_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_1(
    .xposit (mtx_2[15:8]),
    .decoded_posit (col2_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_2(
    .xposit (mtx_2[23:16]),
    .decoded_posit (col2_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_3(
    .xposit (mtx_2[31:24]),
    .decoded_posit (col2_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_4(
    .xposit (mtx_2[39:32]),
    .decoded_posit (col2_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_5(
    .xposit (mtx_2[47:40]),
    .decoded_posit (col2_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_6(
    .xposit (mtx_2[55:48]),
    .decoded_posit (col2_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col2_vector_7(
    .xposit (mtx_2[63:56]),
    .decoded_posit (col2_vector[7]));

  mullinrow_3 mullinrow_3_acc_3(
    .vec (vec),
    .acc (acc_2),
    .mtx (col_2),
    .result_acc (acc_3));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_0(
    .xposit (mtx_3[7:0]),
    .decoded_posit (col3_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_1(
    .xposit (mtx_3[15:8]),
    .decoded_posit (col3_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_2(
    .xposit (mtx_3[23:16]),
    .decoded_posit (col3_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_3(
    .xposit (mtx_3[31:24]),
    .decoded_posit (col3_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_4(
    .xposit (mtx_3[39:32]),
    .decoded_posit (col3_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_5(
    .xposit (mtx_3[47:40]),
    .decoded_posit (col3_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_6(
    .xposit (mtx_3[55:48]),
    .decoded_posit (col3_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col3_vector_7(
    .xposit (mtx_3[63:56]),
    .decoded_posit (col3_vector[7]));

  mullinrow_4 mullinrow_4_acc_4(
    .vec (vec),
    .acc (acc_3),
    .mtx (col_3),
    .result_acc (acc_4));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_0(
    .xposit (mtx_4[7:0]),
    .decoded_posit (col4_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_1(
    .xposit (mtx_4[15:8]),
    .decoded_posit (col4_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_2(
    .xposit (mtx_4[23:16]),
    .decoded_posit (col4_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_3(
    .xposit (mtx_4[31:24]),
    .decoded_posit (col4_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_4(
    .xposit (mtx_4[39:32]),
    .decoded_posit (col4_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_5(
    .xposit (mtx_4[47:40]),
    .decoded_posit (col4_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_6(
    .xposit (mtx_4[55:48]),
    .decoded_posit (col4_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col4_vector_7(
    .xposit (mtx_4[63:56]),
    .decoded_posit (col4_vector[7]));

  mullinrow_5 mullinrow_5_acc_5(
    .vec (vec),
    .acc (acc_4),
    .mtx (col_4),
    .result_acc (acc_5));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_0(
    .xposit (mtx_5[7:0]),
    .decoded_posit (col5_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_1(
    .xposit (mtx_5[15:8]),
    .decoded_posit (col5_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_2(
    .xposit (mtx_5[23:16]),
    .decoded_posit (col5_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_3(
    .xposit (mtx_5[31:24]),
    .decoded_posit (col5_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_4(
    .xposit (mtx_5[39:32]),
    .decoded_posit (col5_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_5(
    .xposit (mtx_5[47:40]),
    .decoded_posit (col5_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_6(
    .xposit (mtx_5[55:48]),
    .decoded_posit (col5_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col5_vector_7(
    .xposit (mtx_5[63:56]),
    .decoded_posit (col5_vector[7]));

  mullinrow_6 mullinrow_6_acc_6(
    .vec (vec),
    .acc (acc_5),
    .mtx (col_5),
    .result_acc (acc_6));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_0(
    .xposit (mtx_6[7:0]),
    .decoded_posit (col6_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_1(
    .xposit (mtx_6[15:8]),
    .decoded_posit (col6_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_2(
    .xposit (mtx_6[23:16]),
    .decoded_posit (col6_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_3(
    .xposit (mtx_6[31:24]),
    .decoded_posit (col6_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_4(
    .xposit (mtx_6[39:32]),
    .decoded_posit (col6_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_5(
    .xposit (mtx_6[47:40]),
    .decoded_posit (col6_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_6(
    .xposit (mtx_6[55:48]),
    .decoded_posit (col6_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col6_vector_7(
    .xposit (mtx_6[63:56]),
    .decoded_posit (col6_vector[7]));

  mullinrow_7 mullinrow_7_acc_7(
    .vec (vec),
    .acc (acc_6),
    .mtx (col_6),
    .result_acc (acc_7));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_0(
    .xposit (mtx_7[7:0]),
    .decoded_posit (col7_vector[0]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_1(
    .xposit (mtx_7[15:8]),
    .decoded_posit (col7_vector[1]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_2(
    .xposit (mtx_7[23:16]),
    .decoded_posit (col7_vector[2]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_3(
    .xposit (mtx_7[31:24]),
    .decoded_posit (col7_vector[3]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_4(
    .xposit (mtx_7[39:32]),
    .decoded_posit (col7_vector[4]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_5(
    .xposit (mtx_7[47:40]),
    .decoded_posit (col7_vector[5]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_6(
    .xposit (mtx_7[55:48]),
    .decoded_posit (col7_vector[6]));

  decode_posit_wrapper8 decode_posit_wrapper8_col7_vector_7(
    .xposit (mtx_7[63:56]),
    .decoded_posit (col7_vector[7]));

  mullinrow_8 mullinrow_8_acc_8(
    .vec (vec),
    .acc (acc_7),
    .mtx (col_7),
    .result_acc (acc_8));

  encode_posit_wrapper encode_posit_wrapper_res_wires_0(
    .xposit (acc_8[23:0]),
    .result (res_wires[0]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_1(
    .xposit (acc_8[47:24]),
    .result (res_wires[1]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_2(
    .xposit (acc_8[71:48]),
    .result (res_wires[2]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_3(
    .xposit (acc_8[95:72]),
    .result (res_wires[3]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_4(
    .xposit (acc_8[119:96]),
    .result (res_wires[4]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_5(
    .xposit (acc_8[143:120]),
    .result (res_wires[5]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_6(
    .xposit (acc_8[167:144]),
    .result (res_wires[6]));

  encode_posit_wrapper encode_posit_wrapper_res_wires_7(
    .xposit (acc_8[191:168]),
    .result (res_wires[7]));

  assign acc_0 = {initial_accumulators[7],initial_accumulators[6],initial_accumulators[5],initial_accumulators[4],initial_accumulators[3],initial_accumulators[2],initial_accumulators[1],initial_accumulators[0]};
  assign vec = {initial_vector[0],initial_vector[1],initial_vector[2],initial_vector[3],initial_vector[4],initial_vector[5],initial_vector[6],initial_vector[7]};
  assign col_0 = {col0_vector[0],col0_vector[1],col0_vector[2],col0_vector[3],col0_vector[4],col0_vector[5],col0_vector[6],col0_vector[7]};
  assign col_1 = {col1_vector[0],col1_vector[1],col1_vector[2],col1_vector[3],col1_vector[4],col1_vector[5],col1_vector[6],col1_vector[7]};
  assign col_2 = {col2_vector[0],col2_vector[1],col2_vector[2],col2_vector[3],col2_vector[4],col2_vector[5],col2_vector[6],col2_vector[7]};
  assign col_3 = {col3_vector[0],col3_vector[1],col3_vector[2],col3_vector[3],col3_vector[4],col3_vector[5],col3_vector[6],col3_vector[7]};
  assign col_4 = {col4_vector[0],col4_vector[1],col4_vector[2],col4_vector[3],col4_vector[4],col4_vector[5],col4_vector[6],col4_vector[7]};
  assign col_5 = {col5_vector[0],col5_vector[1],col5_vector[2],col5_vector[3],col5_vector[4],col5_vector[5],col5_vector[6],col5_vector[7]};
  assign col_6 = {col6_vector[0],col6_vector[1],col6_vector[2],col6_vector[3],col6_vector[4],col6_vector[5],col6_vector[6],col6_vector[7]};
  assign col_7 = {col7_vector[0],col7_vector[1],col7_vector[2],col7_vector[3],col7_vector[4],col7_vector[5],col7_vector[6],col7_vector[7]};
  assign res_lsb = {res_wires[4],res_wires[5],res_wires[6],res_wires[7]};
  assign res_msb = {res_wires[0],res_wires[1],res_wires[2],res_wires[3]};
endmodule

