
module test_bench();

  reg [7:0] posit;
  wire [11:0] result;

  decode_posit_8bit decoder(
    .posit 		(posit),
    .eposit     (result));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    #10 assign posit=8'h80;  // should be inf
    #10 assign posit=8'h00;  // should be zero
    #10 assign posit=8'h76;  // 0x138
    #10 assign posit=8'h16;  // 0x0ad
    #10 assign posit=8'h57;  // 0x0f7
    #10 assign posit=8'h8a;  // 0x328
    #10 assign posit=8'hea;  // 0x2b4
    #10 assign posit=8'ha9;  // 0x2e9
    #10;
  end

endmodule
