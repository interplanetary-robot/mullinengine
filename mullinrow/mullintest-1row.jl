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
