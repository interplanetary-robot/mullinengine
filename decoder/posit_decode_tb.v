module test_bench();

  reg [7:0] posit;
  wire [11:0] test;

  posit_decode_8bit decoder(
    .posit 		(posit),
    .uposit     (test));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    #10 assign posit=8'h76;  // 0b0_1000_11000 =>0x118
    #10 assign posit=8'h16;  // 0b0_0100_01100 => 0x08d
    #10 assign posit=8'h57;  // 0b0_0110_10111 => 0x0e7
    #10 assign posit=8'h8a;  // 0x318
    #10 assign posit=8'hea;  // 0x28d
    #10 assign posit=8'ha9;  // 0x2e7
    #10;
  end

endmodule
