################################################################################
## TEST THE multilanguage c wrapper.

function test_c_conversions()
  cd(()-> begin
    run(`cc -fpic -c posit_conversions.cpp`)
    run(`cc -shared -o libPC.so posit_conversions.o`)
  end, "./cgen-code/")

  #next, load the shared object file.

  d216 = eval(:((x) -> ccall((:double_to_posit16, "./cgen-code/libPC.so"), UInt16, (Float64,), x)))

  P16 = Posit{16,0}

  #next test that all posit conversions of posit values are valid.
  for pi = 0x0000:0xFFFF
    fv = Float64(P16(pi))
    @test d216(fv) == pi
  end

  print("testing 16-bit Float->Posit...")
  for idx = 1:1000
    fv = (rand(Bool) ? -1 : 1) *  (rand() + 1.0) * 2.0 ^ (rand(-17:17))
    dv = P16(d216(fv))
    pv = P16(fv)
    @test dv == pv
  end
  println("OK")

  d28 = eval(:((x) -> ccall((:double_to_posit8, "./cgen-code/libPC.so"), UInt8, (Float64,), x)))

  P8 = Posit{8,0}

  #next test that all 8-bit posit conversions of float values are valid.
  for pi = 0x00:0xFF
    fv = Float64(P8(pi))
    @test d28(fv) == pi
  end

  print("testing 8-bit Float->Posit...")
  for idx = 1:1000
    fv = (rand(Bool) ? -1 : 1) *  (rand() + 1.0) * 2.0 ^ (rand(-11:11))
    dv = P8(d28(fv))
    pv = P8(fv)
    @test dv == pv
  end
  println("OK!")

  #next test that backconversion from 16-bit posit values are valid
  p2d = eval(:((x) -> ccall((:posit16_to_double, "./cgen-code/libPC.so"), Float64, (UInt16,), x)))

  print("testing 16-bit Posit->Float...")
  for pi = 0x0000:0xFFFF
    fv = Float64(P16(pi))
    @test (p2d(pi), pi) == (fv, pi)
  end
  println("OK!")
end

# a function that creates the c part.

function generate_c_library()
  #first verilate the most critical function.
  verilate(mullin_8row_c_wrapper, (), path = "./cgen", with_source = true)
  #next copy the library shim code over.
  xferfiles = ["mullinsim.cpp", "posit_conversions.cpp"]
  srcfiles = map((s) -> string("./cgen-code/", s), xferfiles)
  dstfiles = map((s) -> string("./cgen/", s), xferfiles)

  cp.(srcfiles, dstfiles)
end

# wraps the c function that is as follows:
# matrixmult64(double *res, double *mtx, double *vec, double *acc)
function matrixfma!(res::Vector{Float64}, mtx::Matrix{Float64}, vec::Vector{Float64}, acc::Vector{Float64})
  #make a transposed matrix so that julia can pass a column-major form
  #to the row-major form preferred by C.
  mtx_t = mtx'

  #create pointer variables out of the vector values.
  res_p = pointer(res)
  mtx_p = pointer(mtx_t)
  vec_p = pointer(vec)
  acc_p = pointer(acc)

  #actually do the ccall.
  ccall((:matrixmult64, "libsimc.so"), Void,
    (Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
    res_p, mtx_p, vec_p, acc_p)
end

#now, actually test everything.

function test_multilanguage_c_wrapper()
  P16 = Posit{16, 0}
  P8 = Posit{8,0}
  for idx = 1:100  #do a 100 trials, why not.
    #generate the accumulator, vector, and matrix.
    posit_acc = P16.(rand(UInt16, 8))
    posit_mtx = P8.(rand(UInt8, 8, 8))
    posit_vec = P8.(rand(UInt8, 8))

    float_acc = Float64.(posit_acc)
    float_mtx = Float64.(posit_mtx)
    float_vec = Float64.(posit_vec)
    float_res = Vector{Float64}(8)

    #do the matrix-fma
    matrixfma!(float_res, float_mtx, float_vec, float_acc)

  end
end
