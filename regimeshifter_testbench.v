module test_bench();

  reg [7:0] posit;
  wire [5:0] frc;


  regimeshifter_8bit regimeshifter(
    .posit (posit),
    .frc   (frc));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    #10 assign posit=8'b01110110;
    #10 assign posit=8'b00010110;
    #10 assign posit=8'b01010111;
    #10;
  end

endmodule
