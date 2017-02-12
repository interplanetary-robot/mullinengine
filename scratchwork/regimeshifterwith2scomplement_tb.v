module test_bench();

  reg [7:0] posit;
  wire [9:0] test;

  regimeshifter_with_exp_8bit regimeshifter(
    .posit 		(posit),
    .eposit     (test));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    #10 assign posit=8'b01110110;  // 0x76 expects 0x118
    #10 assign posit=8'b00010110;  // 0x16 expects 0x8c
    #10 assign posit=8'b01010111;  // 0x57 expects 0xd7
    #10;
  end

endmodule
