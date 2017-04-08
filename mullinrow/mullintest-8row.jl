
n2pw16(n) = decode_posit(Wire(n, 16), 16)
n2pw8(n) = decode_posit(Wire(n, 8), 8)

################################################################################
# testing a full mullin row.
function mullin_nrow_wrapper(accumulators::Vector{UInt16}, matrixvals::Matrix{UInt16}, vectorvals::Vector{UInt16}, rows)
  accwire = Wire(n2pw16(accumulators[1]), Wire(0x0,3))

  mtxwire = Vector{Wire}(8)
  for idx = 1:8
    mtxwire[idx] = Wire(n2pw8(matrixvals[1, idx] >> 8), Wire(0x0,3))
  end
  vecwire = Wire(n2pw8(vectorvals[1] >> 8), Wire(0x0, 3))

  #assemble the wires!
  for idx = 2:8
    accwire = Wire(accwire, n2pw16(accumulators[idx]), Wire(0x0,3))

    for jdx = 1:8
      mtxwire[jdx] = Wire(mtxwire[jdx], n2pw8(matrixvals[idx, jdx] >> 8), Wire(0x0,3))
    end

    vecwire = Wire(n2pw8(vectorvals[idx] >> 8), Wire(0x0,3), vecwire)
  end

#  println("----")
#  println(hex(vectorvals[8] >> 8))
#  println(n2pw8(vectorvals[8] >> 8))
#  println(vecwire)
#  println("----")
#
#  println("accwire, 0:", accwire)

  for idx = 1:8
    accwire = mullinrow(vecwire, accwire, mtxwire[idx], idx)
  end

  row_answer = Vector{UInt64}(8)
  for idx = 1:8
    #pull the temporary row values.
    temp_row = accwire[(idx * 24 - 1):((idx-1) * 24)v]

    #maybe we need to consider a better way to handle this.
    temp_row[23].values[1] && temp_row[22].values[1] && throw(SigmoidNumbers.NaNError(mullin_nrow_wrapper, [accumulators, matrixvals, vectorvals]))

    row_answer[9-idx] = Unsigned(encode_posit(temp_row[23], temp_row[22], temp_row[21], temp_row[20:16v], temp_row[15:3v],temp_row[2:1v], 16))
  end
  row_answer
end

const P16 = Posit{16,0}

function identity_test_me()
  accumulators_i = [0x0000 for n in 1:8]
  matrixvals_i   = [(n == m) ? (0x4000) : 0x0000 for n in 1:8, m in 1:8]
  vectorvals_i   = [0x0400,0x0400,0x0400,0x0400,0x0400,0x0400,0x0400,0x8800]

  println(join(hex.(vectorvals_i), " "))

  row_answer = mullin_nrow_wrapper(accumulators_i, matrixvals_i, vectorvals_i, 8)

  println(UInt16.(row_answer))
  println(Int.(row_answer .== vectorvals_i))
end


function identity_test_mullin_8rows()
  good_count = 0
  #do this 1:1000
  for round in 1:200

    accumulators_i = [0x0000 for n in 1:8]
    matrixvals_i   = [(n == m) ? (0x4000) : 0x0000 for n in 1:8, m in 1:8]
    vectorvals_i   = [rand(0x0000:0x0100:0xFF00) for n in 1:8]

    try
      #get the wrapped results, should be Unsigned 64-bit ints.
      row_answer = mullin_nrow_wrapper(accumulators_i, matrixvals_i, vectorvals_i, 8)

      if row_answer == vectorvals_i
        good_count += 1
      else
        println(Int.(row_answer .== vectorvals_i), ":", vectorvals_i)
      end

    catch e
      #skip over NaNs.
      if isa(e,SigmoidNumbers.NaNError)
        continue
      end

      rethrow()
    end
  end
  println("goods: $good_count/200")
end


function test_mullin_8rows()
  better_count = 0
  worse_count = 0
  #do this 1:1000
  for round in 1:1000

    accumulators_i = [rand(0x0000:0xFFFF) for n in 1:8]
    matrixvals_i   = [rand(0x0000:0x0100:0xFF00) for n in 1:8, m in 1:8]
    vectorvals_i   = [rand(0x0000:0x0100:0xFF00) for n in 1:8]

    #directly broadcast these as conversions to 16-bit posits
    accumulators_p = P16.(accumulators_i)
    matrixvals_p = P16.(matrixvals_i)
    vectorvals_p = P16.(vectorvals_i)

    try
      res_p = Float64.(matrixvals_p * vectorvals_p + accumulators_p)

      res_f = Float64.(matrixvals_p) * Float64.(vectorvals_p) + Float64.(accumulators_p)

      #get the wrapped results, should be Unsigned 64-bit ints.
      row_answer = mullin_nrow_wrapper(accumulators_i, matrixvals_i, vectorvals_i, 8)

      #broadcast the row to be 16-bit posit
      res_m = Float64.(P16.(row_answer))

      if |(isfinite.(res_p)...)
        better_count += sum(abs(res_p - res_f) .> abs(res_m - res_f))
        worse_count  += sum(abs(res_p - res_f) .< abs(res_m - res_f))
      end

    catch e
      #skip over NaNs.
      if isa(e,SigmoidNumbers.NaNError)
        continue
      end

      rethrow()
    end
  end

  println("fused better percentage: ",     better_count / 80, "%")
  println("sequential better percentage: ", worse_count / 80, "%")
end
