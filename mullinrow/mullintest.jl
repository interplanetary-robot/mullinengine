#mullintest.jl  -test stuff for mullin engine components

################################################################################
#test mullin mul component

doc"""
  wraps mullin_mul so that you can call it as fused wires.
"""
@verilog function mullin_mul_wrapper(lhs::Wire{7:0v}, rhs::Wire{7:0v})
  lhs_dec = decode_posit(lhs, 8)
  rhs_dec = decode_posit(rhs, 8)

  lhs_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3))
  rhs_frc = Wire(rhs_dec[4:0v], Wire(0x0, 3))

  #generate a the muliply fraction, like the mullin engine does.
  mul_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3)) * Wire(rhs_dec[4:0v], Wire(0x0, 3))

  #perform mullin_mul
  mul_s, mul_e, mul_f = mullin_mul(lhs_dec[11:9v], lhs_dec[8:5v], lhs_frc,
                                   rhs_dec[11:9v], rhs_dec[8:5v], rhs_frc,
                                   mul_frc, 8, 16)

  mul_gs = Wire(0x0, 2)

  rhs_dec = encode_posit(mul_s[2], mul_s[1], mul_s[0], mul_e, mul_f[msb:3v], mul_gs, 16)
end

function test_mullin_mul()
  #first make sure this makes sense at all.

  test_one = 0x4000
  test_res = mullin_mul_wrapper(test_one >> 8, test_one >> 8) << 48
  @test test_res == 0x4000_0000_0000_0000

  #test this comprehensively.
  print("testing mullin multiplier...")
  @time for lhs = 0x0000:0x0100:0xFF00
    for rhs = 0x0000:0x0100:0xFF00
      lhs_s = Posit{16,0}(lhs)
      rhs_s = Posit{16,0}(rhs)
      try
        resp = lhs_s * rhs_s

        res = mullin_mul_wrapper(lhs >> 8, rhs >> 8) << 48

        @test (reinterpret(Posit{16,0},res), lhs, rhs) == (resp, lhs, rhs)
      catch e
        #skip over NaNs.
        if isa(e,SigmoidNumbers.NaNError)
          continue
        end

        rethrow()
      end
    end
  end
  println("OK.")
end

################################################################################
# testing mullin add component

doc"""
  wraps mullin_add so that you can call it as fused wires.
"""
@verilog function mullin_add_wrapper(lhs::Wire{15:0v}, rhs::Wire{15:0v})
  lhs_dec = decode_posit(lhs, 16)
  rhs_dec = decode_posit(rhs, 16)

  lhs_s = lhs_dec[20:18v]
  rhs_s = rhs_dec[20:18v]

  lhs_e = lhs_dec[17:13v]
  rhs_e = rhs_dec[17:13v]

  lhs_f = Wire(lhs_dec[12:0v], Wire(0x0, 3))
  rhs_f = Wire(rhs_dec[12:0v], Wire(0x0, 3))

  #perform pre-shifting and adding the fractions for addition.  This may be replaced by a
  #different function in the future, that can accomodate different modes.
  add_sgn, add_provisional_exp, add_provisional_frc = mullin_frc_add(lhs_s, lhs_e, lhs_f,
                                                                     rhs_s, rhs_e, rhs_f, 16)

  #check for zeros.
  add_zer = add_zero_checker(lhs_s[0], lhs_e, lhs_f[msb:3v],
                             rhs_s[0], rhs_e, rhs_f[msb:3v], 16)

  #set result state variables.
  add_s   = mullin_addition_state(lhs_s, rhs_s, add_sgn, add_zer)

  #then do post-shift adjustment stuff.
  add_exp, add_frc = mullin_addition_cleanup(add_sgn, add_provisional_exp, add_provisional_frc, 16)

  #for analysis.  In the "actual" function this will be put back into the accumulator.
  rhs_dec = encode_posit(add_s[2], add_s[1], add_s[0], add_exp, add_frc[msb:3v], add_frc[2:1v], 16)
end

function test_mullin_add()
  #test this comprehensively.
  print("testing mullin adder...")
  @time for lhs = 0x0000:0x0100:0xFF00
    for rhs = 0x0000:0x0100:0xFF00
      res = mullin_add_wrapper(lhs, rhs) << 48

      lhs_s = Posit{16,0}(lhs)
      rhs_s = Posit{16,0}(rhs)

      try
        resp = lhs_s + rhs_s

        res = mullin_add_wrapper(lhs, rhs) << 48

        @test (reinterpret(Posit{16,0},res), lhs, rhs) == (resp, lhs, rhs)
      catch e
        #skip over NaNs.
        if isa(e,SigmoidNumbers.NaNError)
          continue
        end

        rethrow()
      end
    end
  end
  println("OK.")
end

#=
lhs_i = 0x700a
rhs_i = 0x1c91
lhs_p = Posit{16,0}(lhs_i)
rhs_p = Posit{16,0}(rhs_i)

println("posit_sum:", lhs_p + rhs_p)
println("----------")
println("std_add_sum: 0x", hex(posit_adder(lhs_i, rhs_i, 16),4))
println("----------")
println("mullin_wrapper: 0x", hex(mullin_add_wrapper(lhs_i, rhs_i),4))
exit()
=#

################################################################################
# testing a full mullin row.
function mullin_row_wrapper(acc_d_w::Vector{Wire{15:0v}}, mtx_d_w::Vector{Wire{7:0v}}, vec_d_w::Wire{7:0v})

  acc_wire = Wire(decode_posit(acc_d_w[1], 16), Wire(0x0,3))
  mtx_wire = Wire(decode_posit(mtx_d_w[1], 8) , Wire(0x0,3))

  for idx = 2:8
    acc_wire = Wire(acc_wire, decode_posit(acc_d_w[idx], 16), Wire(0x0,3))
    mtx_wire = Wire(mtx_wire, decode_posit(mtx_d_w[idx], 8) , Wire(0x0,3))
  end

  this_vec = Wire(decode_posit(vec_d_w, 8), Wire(0x0, 3))

  row_result = mullinrow(this_vec, acc_wire, mtx_wire)

  row_answer = Vector{UInt64}(8)
  for idx = 1:8
    #pull the temporary row values.
    temp_row = row_result[(idx * 24 - 1):((idx-1) * 24)v]

    row_answer[9-idx] = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v], temp_row[2:1v], 16))
  end
  row_answer
end

prettyfloat(x) = string(Float64(x),"          ")[1:7]

function test_mullin_row()
  #do this 1:1000
  for round in 1:1000
    acc_d_i = [rand(0x0000:0xFFFF) for idx in 1:8]
    mtx_d_i = [rand(0x0000:0x0100:0xFF00) for idx in 1:8]
    vec_d_i = rand(0x0000:0x0100:0xFF00)

    acc_d_w = [Wire(v, 16)     for v in acc_d_i]
    mtx_d_w = [Wire(v >> 8, 8) for v in mtx_d_i]
    vec_d_w = Wire(vec_d_i >> 8, 8)

    acc_d_p = [Posit{16,0}(v) for v in acc_d_i]
    mtx_d_p = [Posit{16,0}(v) for v in mtx_d_i]
    vec_d_p = Posit{16,0}(vec_d_i)

    try
      #get the wrapped results, should be Unsigned 64-bit ints.
      row_answer = mullin_row_wrapper(acc_d_w, mtx_d_w, vec_d_w)

      for idx = 1:8
        #calculate the "true" value.
        true_value = Float64(acc_d_p[idx]) + Float64(mtx_d_p[idx]) * Float64(vec_d_p)
        print(idx, " ", acc_d_p[idx], " + ", mtx_d_p[idx], " * ", vec_d_p, " ≈ ",  Posit{16,0}(true_value))

        float_true_value = Float64(Posit{16,0}(true_value))

        posit_result = acc_d_p[idx] + mtx_d_p[idx] * vec_d_p
        mullin_result = Posit{16,0}(row_answer[idx])

        posit_result_f = Float64(posit_result)
        mullin_result_f = Float64(mullin_result)

        println(" posit: $(prettyfloat(posit_result)) ($posit_result), mullin: $(prettyfloat(mullin_result)) ($mullin_result)")

        if isfinite(posit_result_f) && isfinite(mullin_result_f) && isfinite(float_true_value)
          @test abs(posit_result_f - float_true_value) >= abs(mullin_result_f - float_true_value)
        end
      end

    catch e
      #skip over NaNs.
      if isa(e,SigmoidNumbers.NaNError)
        continue
      end

      rethrow()
    end
  end
end

################################################################################
# testing a full mullin row.
function mullin_2row_wrapper(acc1_d_w::Vector{Wire{15:0v}}, mtx1_d_w::Vector{Wire{7:0v}}, vec1_d_w::Wire{7:0v},
                             mtx2_d_w::Vector{Wire{7:0v}}, vec2_d_w::Wire{7:0v})

  acc1_wire = Wire(decode_posit(acc1_d_w[1], 16), Wire(0x0,3))
  mtx1_wire = Wire(decode_posit(mtx1_d_w[1], 8) , Wire(0x0,3))
  mtx2_wire = Wire(decode_posit(mtx2_d_w[1], 8) , Wire(0x0,3))

  for idx = 2:8
    acc1_wire = Wire(acc1_wire, decode_posit(acc1_d_w[idx], 16), Wire(0x0,3))
    mtx1_wire = Wire(mtx1_wire, decode_posit(mtx1_d_w[idx], 8) , Wire(0x0,3))
    mtx2_wire = Wire(mtx2_wire, decode_posit(mtx2_d_w[idx], 8) , Wire(0x0,3))
  end

  this_vec1 = Wire(decode_posit(vec1_d_w, 8), Wire(0x0, 3))
  this_vec2 = Wire(decode_posit(vec2_d_w, 8), Wire(0x0, 3))

  acc2_wire = mullinrow(this_vec1, acc1_wire, mtx1_wire)

  #sample one data point for debugging purposes.
  tidx = 7
  temp_row = acc2_wire[(tidx * 24 - 1):((tidx-1) * 24)v]
  sample = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v],temp_row[2:1v], 16))
  println("frc:", temp_row[15:0v])
  println("sample:", hex(sample, 4))

  acc3_wire = mullinrow(this_vec2, acc2_wire, mtx2_wire)

  row_answer = Vector{UInt64}(8)
  for idx = 1:8
    #pull the temporary row values.
    temp_row = acc3_wire[(idx * 24 - 1):((idx-1) * 24)v]

    row_answer[9-idx] = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v],temp_row[2:1v], 16))
  end
  row_answer
end


function test_mullin_2rows()
  #do this 1:1000
  for round in 1:1000
    acc1_d_i = [rand(0x0000:0xFFFF) for idx in 1:8]
    mtx1_d_i = [rand(0x0000:0x0100:0xFF00) for idx in 1:8]
    mtx2_d_i = [rand(0x0000:0x0100:0xFF00) for idx in 1:8]
    vec1_d_i = rand(0x0000:0x0100:0xFF00)
    vec2_d_i = rand(0x0000:0x0100:0xFF00)

    acc1_d_w = [Wire(v, 16)     for v in acc1_d_i]
    mtx1_d_w = [Wire(v >> 8, 8) for v in mtx1_d_i]
    mtx2_d_w = [Wire(v >> 8, 8) for v in mtx2_d_i]
    vec1_d_w = Wire(vec1_d_i >> 8, 8)
    vec2_d_w = Wire(vec2_d_i >> 8, 8)

    acc1_d_p = [Posit{16,0}(v) for v in acc1_d_i]
    mtx1_d_p = [Posit{16,0}(v) for v in mtx1_d_i]
    mtx2_d_p = [Posit{16,0}(v) for v in mtx2_d_i]
    vec1_d_p = Posit{16,0}(vec1_d_i)
    vec2_d_p = Posit{16,0}(vec2_d_i)

    println("acc  = ", acc1_d_p[2])
    println("mtx1 = ", mtx1_d_p[2])
    println("mtx2 = ", mtx2_d_p[2])
    println("vec1 = ", vec1_d_p)
    println("vec2 = ", vec2_d_p)

    try
      #get the wrapped results, should be Unsigned 64-bit ints.
      row_answer = mullin_2row_wrapper(acc1_d_w, mtx1_d_w, vec1_d_w,
                                       mtx2_d_w, vec2_d_w)

      for idx = 1:8
        true_value = Float64(acc1_d_p[idx]) + Float64(mtx1_d_p[idx]) * Float64(vec1_d_p) + Float64(mtx2_d_p[idx]) * Float64(vec2_d_p)
        posit_result = Float64(acc1_d_p[idx] + mtx1_d_p[idx] * vec1_d_p + mtx2_d_p[idx] * vec2_d_p)
        mullin_result = Float64(Posit{16,0}(row_answer[idx]))

        println(idx, " ", prettyfloat(acc1_d_p[idx]), " + ", prettyfloat(mtx1_d_p[idx]), " * ", prettyfloat(vec1_d_p),
                " + ", prettyfloat(mtx2_d_p[idx]), " * ", prettyfloat(vec2_d_p), " = ", prettyfloat(true_value),
                " posit: ", prettyfloat(posit_result), " mullin: ", prettyfloat(mullin_result))

        if isfinite(true_value) && isfinite(posit_result) && isfinite(mullin_result)
          @test abs(posit_result - true_value) >= abs(mullin_result - true_value)
        end
      end

    catch e
      #skip over NaNs.
      if isa(e,SigmoidNumbers.NaNError)
        continue
      end

      rethrow()
    end
  end
end
