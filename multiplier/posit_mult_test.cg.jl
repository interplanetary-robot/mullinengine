enc_file = generate_verilog_file("verilog/", encode_posit, (8,))
dec_file = generate_verilog_file("verilog/", decode_posit, (8,))
codec_files = union(enc_file, dec_file)
generate_verilog_file("verilog/", posit_multiplier, (8,8), exclude = codec_files)

#verilation
verilate(posit_multiplier, (8,8))
@vfunc

print("testing codegen 8bit...")
for idx1 in 0x00:0xFF
  for idx2 in 0x00:0xFF
    @test (veval(idx1, idx2), idx1, idx2) == (posit_multiplier(idx1, idx2, 8, 8), idx1, idx2)
  end
end
println("OK!")
