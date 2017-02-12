// Code your design here
module abs_8bit(
  input  [7:0] posit,
  output [7:0] result);

  assign result = (-posit[7:0] & {8{posit[7]}}) | (posit[7:0] & {8{~posit[7]}});

endmodule
