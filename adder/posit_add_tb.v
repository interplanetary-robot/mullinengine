// Code your testbench here
// or browse Examples

module adder_tb();

  //create registers
  reg [7:0] lhs;
  reg [7:0] rhs;
  wire [7:0] res;

  //declare the multiply block here.
  posit_adder_8bit add8(
    .lhs        (lhs),
    .rhs        (rhs),
    .add_result (res));

  initial begin

    $dumpfile("dump.vcd");
    $dumpvars;

    #10;
    assign lhs = 8'h02;
    assign rhs = 8'hff;
    #10;

  end
endmodule
