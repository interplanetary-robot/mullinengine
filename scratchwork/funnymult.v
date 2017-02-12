module frac_hidden_cross_8bit(
  input  cross_sign_bit,
  input  [4:0] frac_bits,
  output [7:0] result_line);

  wire [4:0] shifted_frac;
  wire [4:0] static_frac;
  wire leading_ones;

  assign shifted_frac = {5{cross_sign_bit}} & -frac_bits;
  assign static_frac  = {5{!cross_sign_bit}} & frac_bits;
  assign leading_ones = (|(inverse_frac)) & cross_sign_bit;

  assign output[7:6]   = {2{leading_ones}};
  assign output[5]     = shifted_frac[4];
  assign output[4:1]   = shifted_frac[3:0] | static_frac[4:1];
  assign output[0]     = static_frac[0];
endmodule

module hidden_bit_product(
  input left_neg, right_neg,
  output[2:0] topbits);

  wire crossproduct;

  assign crossproduct = left_neg ^ right_neg;

  assign topbits[2] = crossproduct | (left_neg & right_neg);
  assign topbits[1] = crossproduct;
  assign topbits[0] = !(left_neg | right_neg);
endmodule


module funny_multiplier_8bit(
    input left_neg, right_neg,
    input [4:0] left_frac,
    input [4:0] right_frac,
    output [11:0] result);

    wire [9:0] mulres;

    //wires representing some results which represent hidden bit parts.
    wire [7:0] left_frac_shifted;
    wire [7:0] right_frac_shifted;
    wire [2:0] hidden_bit_product;

    wire [12:0] first_sum;
    wire [12:0] second_sum;
    wire [12:0] last_sum;

    wire sign_bit;
    wire exp_augment;

    frac_hidden_cross_8bit left_frac_right_hidden(
      .cross_sign_bit   (right_neg)
      .frac_bits        (left_frac)
      .result_line      (left_frac_shifted));

    frac_hidden_cross_8bit left_hidden_right_frac(
      .cross_sign_bit   (left_neg),
      .frac_bits        (right_frac),
      .result_line      (right_frac_shifted));

    hidden_bit_product bitprodcalc(
      .left_neg         (left_neg),
      .right_neg        (right_neg),
      .topbits          (hidden_bit_product));

    assign sign_bit = bitprodcalc[1];

    //do the core multiplication
    assign mulres[9:0] = left_frac * right_frac;

    //next, we have to stack some other things on top.
    assign first_sum[12:0]  = {3'b000, mulres[9:0]} + {left_frac_shifted[7:0],5'b00000};
    assign second_sum[12:0] = first_sum[12:0] + {right_frac_shifted[7:0], 5'b00000};
    assign last_sum[12:0]   = second_sum[12:0] + {hidden_bit_product, 10'b0000000000};

    assign exp_augment = sign_bit ^ last_sum[11];

    assign result[11]  = sign_bit;
    assign result[10]  = exp_augment;
    assign result[9:0] = ({10{exp_augment}} & last_sum[10:1]) | ({10{~exp_augment}} & last_sum[9:0]);

endmodule
