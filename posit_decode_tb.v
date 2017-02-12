module test_bench();

  reg [7:0] posit;
  wire [11:0] test;

  posit_decode_8bit decoder(
    .posit 		(posit),
    .dposit     (test));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    //note:  use reference decoder: posit_decode.jl

    #10 assign posit=8'h17;  // hex:ae
    #10 assign posit=8'h90;  // hex:300
    #10 assign posit=8'h0f;  // hex:9c
    #10 assign posit=8'h16;  // hex:ac
    #10 assign posit=8'hea;  // hex:2b4
    #10 assign posit=8'ha9;  // hex:2e9
    #10 assign posit=8'h80;  // infinity: ba0
    #10 assign posit=8'h00;  // zero: 400
    #10;
  end

endmodule
