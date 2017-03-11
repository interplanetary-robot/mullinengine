enc_file = generate_verilog_file("verilog/", encode_posit, (8,))
dec_file = generate_verilog_file("verilog/", decode_posit, (8,))
codec_files = union(enc_file, dec_file)
generate_verilog_file("verilog/", posit_adder, (8,), exclude = codec_files)

#verilation
verilate(posit_adder, (8,))
@vfunc

print("testing codegen 8bit add...")
@time for idx1 in 0x00:0xFF
  for idx2 in 0x00:0xFF
    @test (veval(idx1, idx2), idx1, idx2) == (posit_adder(idx1, idx2, 8), idx1, idx2)
  end
end
println("OK!")
