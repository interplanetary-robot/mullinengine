// Code your testbench here
// or browse Examples
module test_bench();

  reg [7:0] posit;
  wire [7:0] test;

  abs_8bit regimeshifter(
    .posit 		(posit),
    .result     (test));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    #10 assign posit=8'h76;  // 0x76
    #10 assign posit=8'h16;  // 0x16
    #10 assign posit=8'h57;  // 0x57
    #10 assign posit=8'h8a;  // 0x8a
    #10 assign posit=8'hea;  // 0xea
    #10 assign posit=8'ha9;  // 0xa9
    #10;
  end

endmodule
