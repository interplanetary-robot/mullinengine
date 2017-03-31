#a small shim to make life easier.
@verilog function encode_posit_wrapper(xposit::Wire{23:0v})
  gs = Wire(xposit[2], |(xposit[1:0v]))
  result = encode_posit(xposit[23], xposit[22], xposit[21], xposit[20:16v], xposit[15:3v], gs, 16)
end

@verilog function decode_posit_wrapper16(xposit::Wire{15:0v})
  unrolled_posit = decode_posit(xposit,16)
  decoded_posit = Wire(unrolled_posit, Wire(0x0,3))
end

@verilog function decode_posit_wrapper8(xposit::Wire{7:0v})
  unrolled_posit = decode_posit(xposit,8)
  decoded_posit = Wire(unrolled_posit, Wire(0x0,3))
end


doc"""
  mullin_8row_c_wrapper(
    acc_msb::Wire{63:0v},
    acc_lsb::Wire{63:0v},
    vector::Wire{63:0v},
    mtx_0::Wire{63:0v},
    mtx_1::Wire{63:0v},
    mtx_2::Wire{63:0v},
    mtx_3::Wire{63:0v},
    mtx_4::Wire{63:0v},
    mtx_5::Wire{63:0v},
    mtx_6::Wire{63:0v},
    mtx_7::Wire{63:0v})
  is a special wrapper for verilation and testing of the mullin engine using C.
"""
@verilog function mullin_8row_c_wrapper(
  acc_msb::Wire{63:0v},
  acc_lsb::Wire{63:0v},
  vector::Wire{63:0v},
  mtx_0::Wire{63:0v},
  mtx_1::Wire{63:0v},
  mtx_2::Wire{63:0v},
  mtx_3::Wire{63:0v},
  mtx_4::Wire{63:0v},
  mtx_5::Wire{63:0v},
  mtx_6::Wire{63:0v},
  mtx_7::Wire{63:0v})

  #assemble the initial accumulator wires.
  initial_accumulators = Vector{Wire{23:0v}}(8)

  for idx = 1:4
    initial_accumulators[idx] = decode_posit_wrapper16(acc_lsb[(16*idx-1):(16 * (idx - 1))v])
  end
  for idx = 5:8
    initial_accumulators[idx] = decode_posit_wrapper16(acc_msb[(16*idx-65):(16 * (idx - 5))v])
  end
  acc_0 = Wire(initial_accumulators...)

  #assemble the vector wire.
  initial_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    initial_vector[idx] = decode_posit_wrapper8(vector[(8 * idx - 1):(8 * (idx - 1))v])
  end
  vec = Wire(initial_vector...)

  #do each of the matrix lines.  Unfortunately, we can't do this "the right way"
  #because verilator support for wire vectors is uncertain.

  col0_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col0_vector[idx] = decode_posit_wrapper8(mtx_0[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_0 = Wire(col0_vector...)

  acc_1 = mullinrow(vec, acc_0, col_0, 1)

  ##############################################################################

  col1_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col1_vector[idx] = decode_posit_wrapper8(mtx_1[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_1 = Wire(col1_vector...)

  acc_2 = mullinrow(vec, acc_1, col_1, 2)

  ##############################################################################

  col2_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col2_vector[idx] = decode_posit_wrapper8(mtx_2[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_2 = Wire(col2_vector...)

  acc_3 = mullinrow(vec, acc_2, col_2, 3)

  ##############################################################################

  col3_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col3_vector[idx] = decode_posit_wrapper8(mtx_3[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_3 = Wire(col3_vector...)

  acc_4 = mullinrow(vec, acc_3, col_3, 4)

  ##############################################################################

  col4_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col4_vector[idx] = decode_posit_wrapper8(mtx_4[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_4 = Wire(col4_vector...)

  acc_5 = mullinrow(vec, acc_4, col_4, 5)

  ##############################################################################

  col5_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col5_vector[idx] = decode_posit_wrapper8(mtx_5[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_5 = Wire(col5_vector...)

  acc_6 = mullinrow(vec, acc_5, col_5, 6)

  ##############################################################################

  col6_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col6_vector[idx] = decode_posit_wrapper8(mtx_6[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_6 = Wire(col6_vector...)

  acc_7 = mullinrow(vec, acc_6, col_6, 7)

  ##############################################################################

  col7_vector = Vector{Wire{14:0v}}(8)
  for idx = 1:8
    col7_vector[idx] = decode_posit_wrapper8(mtx_7[(8 * idx - 1):(8 * (idx - 1))v])
  end
  col_7 = Wire(col7_vector...)

  acc_8 = mullinrow(vec, acc_7, col_7, 8)

  ##############################################################################

  #begin taking the result accumulator and delivering it to a set of result
  #vectors.
  res_wires = Vector{Wire{15:0v}}(8)
  for idx = 1:8
    res_wires[idx] = encode_posit_wrapper(acc_8[(24 * idx - 1):(24 * (idx - 1))v])
  end

  res_msb = Wire(res_wires[8:-1:5]...)
  res_lsb = Wire(res_wires[4:-1:1]...)

  #emits a 128-bit result vector.
  (res_msb, res_lsb)
end
