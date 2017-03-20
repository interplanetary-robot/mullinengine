
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
  temp_row = acc2_wire[(__VSAMP_ID * 24 - 1):((__VSAMP_ID-1) * 24)v]
  sample = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v],temp_row[2:1v], 16))
  println("frc:", temp_row[15:0v])
  println("sample:", hex(sample, 4))

  println("-----------------------------")

  acc3_wire = mullinrow(this_vec2, acc2_wire, mtx2_wire)

  row_answer = Vector{UInt64}(8)
  for idx = 1:8
    #pull the temporary row values.
    temp_row = acc3_wire[(idx * 24 - 1):((idx-1) * 24)v]

    row_answer[9-idx] = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v],temp_row[2:1v], 16))
  end
  row_answer
end

const __SAMPLE_ID = 3
const __VSAMP_ID = 9 - __SAMPLE_ID

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

    println("========================")

    println("acc  = ", acc1_d_p[__SAMPLE_ID])
    println("mtx1 = ", mtx1_d_p[__SAMPLE_ID])
    println("mtx2 = ", mtx2_d_p[__SAMPLE_ID])
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