module multiply_tb();

  //create registers
  reg clk, rst;
  reg [7:0] lhs;
  reg [7:0] rhs;
  wire [18:0] res;

  //declare the multiply block here.
  multiply_8bit mul8(
    .clk        (clk),
    .leftposit  (lhs),
    .rightposit (rhs),
    .result     (res));

  always begin
    #10 clk = ~clk;
  end

  initial begin

    $dumpfile("dump.vcd");
    $dumpvars;

    //initialize registers to prevent propagation of unknowns.
    clk = 0;
    rst = 0;
    lhs = 8'h00;
    rhs = 8'h00;

    @(posedge clk)
    rst = 1;
    @(posedge clk)
    rst = 0;

    @(posedge clk)
    //set some multiplication variables
    lhs = 8'b00100000;
    rhs = 8'b01100000;
    //-> res should be one.

    @(posedge clk)
    //another multiplication.
    rhs = 8'hdb; //-0.578125
    lhs = 8'h66; //2.75
    //-> res should be: -1.58984375
    // Posit{16} representation:  0xad20
    // unpacked Posit16: 1_01110_1001011100000
    // rehexified: 5d2e0

  end
endmodule
