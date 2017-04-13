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
  filenames = ["mullinsim", "posit_conversions"]
  srcfiles = map((s) -> string("./cgen-code/", s, ".cpp"), filenames)
  dstfiles = map((s) -> string("./cgen/", s, ".cpp"), filenames)
  cp.(srcfiles, dstfiles)

  noncfilenames = ["mullin-c.h", "makefile", "mullin_test.py"]
  srcfiles = map((s) -> string("./cgen-code/", s), noncfilenames)
  dstfiles = map((s) -> string("./cgen/", s), noncfilenames)
  cp.(srcfiles, dstfiles)

  #add in critical verilator header files.
  verilator_headers = ["verilated.h", "verilatedos.h", "verilated_config.h"]
  src_headers = map((s) -> string("/usr/local/share/verilator/include/", s), verilator_headers)
  dst_headers = map((s) -> string("./cgen/obj_dir", s), verilator_headers)
  cp.(src_headers, dst_headers)

  #next actually compile everything.

  object_files = []

  #first handle the stuff that has been verilated.
  cd("./cgen/obj_dir") do
    #run the make file.  This will throw an error due to not finding a --main
    #but that's OK it just needs to make the object files.
    append!(object_files, ["./obj_dir/$f" for f in readdir() if f[end-1:end] == ".o"])
  end

  #next handle the stuff that we're "patching in."
  cd("./cgen") do

    for fn in filenames
      run(`cc -fpic -c $fn.cpp`)
      push!(object_files, "./$fn.o")
    end

    #manually link the object files into a shared library.
    run(`cc -Wall -shared $object_files -o libpositronickernel.so`)
  end
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

  #create a functional call conversion.
  mm64 = eval(:((a,b,c,d) -> ccall((:matrixmult64, "./cgen/libpositronickernel.so"), Void,
    (Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}), a, b, c, d)))

  mm64(res_p, mtx_p, vec_p, acc_p)
end

#now, actually test everything.

function test_multilanguage_c_wrapper()
  P16 = Posit{16, 0}
  P8 = Posit{8,0}

  #initialize the positronic kernel.
  mm_init = eval(:(() -> ccall((:init, "./cgen/libpositronickernel.so"), Void,())))
  mm_init()

  for idx = 1:100  #do a 100 trials, why not.
    #accumulators_i = zeros(UInt16, 8)
    accumulators_i = rand(UInt16, 8)
    matrixvals_i   = [m == 1 ? rand(0x0000:0x0100:0xFF00) : 0x0000 for n in 1:8, m in 1:8]
    vectorvals_i   = [rand(0x0000:0x0100:0xFF00) for n in 1:8]

    float_acc = Float64.(P16.(accumulators_i))
    float_mtx = Float64.(P16.(matrixvals_i))
    float_vec = Float64.(P16.(vectorvals_i))
    float_res = Vector{Float64}(8)

    try

      #do the matrix-fma using the exogenous C library
      matrixfma!(float_res, float_mtx, float_vec, float_acc)

      #we know this corresponds to the legit matrix multiply from elsewhere.
      pfloat_res = mullin_nrow_wrapper(accumulators_i, matrixvals_i, vectorvals_i, 8)

      #test for equality
      fpfloat_res =  Float64.(P16.(pfloat_res))
      @test float_res == fpfloat_res

    catch e
      #skip over NaNs.
      if isa(e,SigmoidNumbers.NaNError)
        continue
      end

      rethrow()
    end

  end
end
