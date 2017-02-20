// testbench for testing set_inf_zero_bits
module test_bench();

  reg sn, az;
  wire [1:0] res;

  set_inf_zero_bits izb(
    .signbit 	  (sn),
    .allzeros     (az),
    .result       (res[1:0]));

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test_bench);

    #10;
    assign sn = {1'b0};
    assign az = {1'b0};
    //expects 0

    #10;
    assign sn = {1'b0};
    assign az = {1'b1};
    //expects 1

    #10;
    assign sn = {1'b1};
    assign az = {1'b0};
    //expects 0

    #10;
    assign sn = {1'b1};
    assign az = {1'b1};
    //expects 2
    #10;
  end

endmodule
