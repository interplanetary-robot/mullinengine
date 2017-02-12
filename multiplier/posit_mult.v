module frac_hidden_cross_8bit(
  input  cross_sign_bit,
  input  [4:0] frac_bits,
  output [6:0] result_line);

  wire [4:0] inverse_frac;
  wire [4:0] shifted_frac;
  wire [4:0] static_frac;
  wire leading_ones;

  assign inverse_frac = -frac_bits;
  assign shifted_frac = {5{cross_sign_bit}} & -frac_bits;
  assign static_frac  = {5{!cross_sign_bit}} & frac_bits;
  assign leading_ones = (|(inverse_frac)) & cross_sign_bit;

  assign result_line[6]     = leading_ones;
  assign result_line[5]     = shifted_frac[4];
  assign result_line[4:1]   = shifted_frac[3:0] | static_frac[4:1];
  assign result_line[0]     = static_frac[0];
endmodule

module hidden_bit_product(
  input left_neg, right_neg,
  output[1:0] topbits);

  assign topbits[1] = left_neg ^ right_neg;
  assign topbits[0] = !(left_neg | right_neg);
endmodule

module frac_mult_8bit(
    input left_neg, right_neg,
    input [4:0] left_frac,
    input [4:0] right_frac,
    output [12:0] result);

    wire [9:0] mulres;

    //wires representing some results which represent hidden bit parts.
    wire [6:0] left_frac_shifted;
    wire [6:0] right_frac_shifted;
    wire [1:0] hidden_bit_product;

    wire [11:0] first_sum;
    wire [11:0] second_sum;
    wire [11:0] last_sum;

    wire sign_bit;
    wire [1:0] exp_augment;

    frac_hidden_cross_8bit left_frac_right_hidden(
      .cross_sign_bit   (right_neg),
      .frac_bits        (left_frac),
      .result_line      (left_frac_shifted));

    frac_hidden_cross_8bit left_hidden_right_frac(
      .cross_sign_bit   (left_neg),
      .frac_bits        (right_frac),
      .result_line      (right_frac_shifted));

    hidden_bit_product bitprodcalc(
      .left_neg         (left_neg),
      .right_neg        (right_neg),
      .topbits          (hidden_bit_product));

    assign sign_bit = hidden_bit_product[1];

    //do the core multiplication
    assign mulres[9:0] = left_frac * right_frac;

    //next, we have to stack some other things on top.
    assign first_sum[11:0]  = {2'b00, mulres[9:0]} + {left_frac_shifted[6:0],5'b00000};
    assign second_sum[11:0] = first_sum[11:0] + {right_frac_shifted[6:0], 5'b00000};
    assign last_sum[11:0]   = second_sum[11:0] + {hidden_bit_product, 10'b0000000000};

    assign exp_augment[1] = ~|(last_sum[11:10]);
    assign exp_augment[0] = sign_bit ^ last_sum[11];

    assign result[12]  = sign_bit;
    assign result[11:10]  = exp_augment;
    assign result[9:0] = ({10{exp_augment[0]}} & last_sum[10:1]) | ({10{~exp_augment[0]}} & last_sum[9:0]);

endmodule

module exp_mult_8bit(
  input [1:0] frac_augment,
  input [3:0] left_exp,
  input [3:0] right_exp,
  output[4:0] result);

  //padded four bit left exponent and right exponent.
  //then add in two if sign_augment is necessary, and one if frac_agument is necessary.
  //then add in one because that is the offset for 8bits -> 16 bits.  e.g.
  //one = exponent 7, 7 + 7 = 14, needs exponent 15 to reach one in 16 bits.
  assign result = {1'b0, left_exp} + {1'b0, right_exp} + {3'b000, frac_augment} + 5'b00001;

endmodule

module posit_mult_check(
  input [1:0] leftflags,
  input [1:0] rightflags,
  output[1:0] resultflags);

  //inf clobbers everything, as does zero.
  //inf * zero yields a NaNerror, which is signalled
  //by having both flags set simultaneously.
  assign resultflags = leftflags | rightflags;
endmodule

//takes two 8-bit posits and mulitplies them yielding a 20-bit result.
module posit_mult_8bit_to_16bit(
  input  [7:0] left_posit,
  input  [7:0] right_posit,
  output [20:0] result);

  //create wires for the decoded posits.
  wire [11:0]dec_left_posit;
  wire [11:0]dec_right_posit;
  wire [1:0]augment_exponent;
  //first decode the two 8-bit posits into decoded versions.
  posit_decode_8bit dcd_left(
    .posit  (left_posit),
    .dposit (dec_left_posit));

  posit_decode_8bit dcd_right(
    .posit  (right_posit),
    .dposit (dec_right_posit));

  posit_mult_check mul_chk(
    .leftflags  (dec_left_posit[11:10]),
    .rightflags (dec_right_posit[11:10]),
    .resultflags(result[20:19]));

  frac_mult_8bit mul_frc(
    .left_neg   (dec_left_posit[9]),
    .right_neg  (dec_right_posit[9]),
    .left_frac  (dec_left_posit[4:0]),
    .right_frac (dec_right_posit[4:0]),
    .result     ({result[18], augment_exponent, result[12:3]})); //set the sign bit, does exponent augment, fraction bits.

  exp_mult_8bit mul_exp(
    .frac_augment (augment_exponent),
    .left_exp     (dec_left_posit[8:5]),
    .right_exp    (dec_right_posit[8:5]),
    .result       (result[17:13]));

  //8b * 8b will never see these slots.
  assign result[2:0] = 3'b000;

endmodule
