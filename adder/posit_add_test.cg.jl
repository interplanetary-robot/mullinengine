#verilation
@verilate(posit_adder, (8,))

print("testing codegen 8bit add...")
@time for idx1 in 0x00:0xFF
  for idx2 in 0x00:0xFF
    @test (posit_adder_8bit_c(idx1, idx2), idx1, idx2) == (posit_adder(idx1, idx2, 8), idx1, idx2)
  end
end
println("OK!")
