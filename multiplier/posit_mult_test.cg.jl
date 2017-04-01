#verilation
@verilate posit_multiplier (8,8)

print("testing codegen 8bit mul...")
@time for idx1 in 0x00:0xFF
  for idx2 in 0x00:0xFF
    @test (posit_multiplier_8bit_c(idx1, idx2), idx1, idx2) == (posit_multiplier(idx1, idx2, 8, 8), idx1, idx2)
  end
end
println("OK!")
