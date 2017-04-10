
#include "mullin-c.h"
#include <stdio.h>
#include <stdint.h>

void exec_matrix_mult(uint16_t *res, uint8_t *mat, uint8_t *vec, uint16_t *acc);

/*******************************************************************************
  matrixmult64(res, mtx, vec, acc)
  matrixmult32(res, mtx, vec, acc)

  performs res = mtx * vec + acc, where acc and vec are 8x1 column vectors and
  mtx is an 8x8 matrix.  res is an 8x1 column vector.  Arithmetic is performed
  using the verilated 8x8 construct.  Caller is responsible for properly
  allocating memory so that it doesn't result in out of bounds.

  Note that "res" and "acc" will carry values that have Posit16 precision to
  emulate direct chaining of these values.
*******************************************************************************/
extern "C" void matrixmult64(double *res, double *mtx, double *vec, double *acc){
  //first allocate the memory that will hold the values.
  //Do this on the stack (for now)
  uint16_t p_acc[8];
  uint8_t  p_vec[8];
  uint8_t  p_mat[64];
  uint16_t p_res[8];

  //convert the accumulator from double to the 16-bit posit.
  for (int idx = 0; idx < 8; idx++){
    p_acc[idx] = double_to_posit16(acc[idx]);
  }

  //convert the vector from double to the 8-bit posit.
  for (int idx = 0; idx < 8; idx++){
    p_vec[idx] = double_to_posit8(vec[idx]);
  }

  //repeat the process for the matrix.  honor c's ROW-major convention.
  for (int idx = 0; idx < 8; idx++){
    for (int jdx = 0; jdx < 8; jdx++){
      p_mat[8 * idx + jdx] = double_to_posit8(mtx[8 * idx + jdx]);
    }
  }

  exec_matrix_mult(p_res, p_mat, p_vec, p_acc);

  //populate the result vector.
  for (int idx = 0; idx < 8; idx++){
    res[idx] = posit16_to_double(p_res[idx]);
  }
}
/*
// for now, only allow computation on 64-bit types
extern "C" void matrixmult32(float *res, float *mtx, float *vec, float *acc){
  //first allocate the memory that will hold the values.
  //Do this on the stack (for now)
  uint16_t p_acc[8];
  uint8_t  p_vec[8];
  uint8_t  p_mat[8][8];
  uint16_t p_res[8];

  //convert the accumulator from double to the 16-bit posit.
  for (idx = 0; idx < 8; idx++){
    p_acc[idx] = single_to_posit16(acc[idx]);
  }

  for (idx = 0; idx < 8; idx++){
    p_vec[idx] = single_to_posit8(vec[idx]);
  }

  //repeat the process for the matrix.  honor c's row-major convention.
  for (idx = 0; idx < 8; idx++){
    for (jdx = 0; jdx < 8; jdx++){
      p_mat[idx][jdx] = single_to_posit8(mtx[8 * idx + jdx])
    }
  }

  exec_matrix_mult(p_res, p_mat, p_vec, p_acc)

  //populate the result vector.
  for (idx = 0; idx < 8; idx++){
    res[idx] = posit16_to_single(p_res[idx]);
  }
}
*/

void exec_matrix_mult(uint16_t *res, uint8_t *mat, uint8_t *vec, uint16_t *acc){
  //first cast all of these pointers to values
  //fix endian-ness problems here.
  uint16_t acc_reordered[] = {acc[3], acc[2], acc[1], acc[0], acc[7], acc[6], acc[5], acc[4]};
  uint64_t * acc_h_ull = (uint64_t *)acc_reordered;
  uint64_t * acc_l_ull = acc_h_ull + 1;

  uint64_t *vec_ull = (uint64_t *) vec;
  //create the matrix vector indices.  Remember that for c pointers, arithmetic
  // addressing follows the sizeof(type) value.
  uint64_t *mat_base = (uint64_t *) mat;

  uint8_t zerovalue = 0x00;

  uint8_t mat_0_reordered[] = {mat[0x00], mat[0x08], mat[0x10], mat[0x18], mat[0x20], mat[0x28], mat[0x30], mat[0x38]};
  uint8_t mat_1_reordered[] = {mat[0x01], mat[0x09], mat[0x11], mat[0x19], mat[0x21], mat[0x29], mat[0x31], mat[0x39]};
  uint8_t mat_2_reordered[] = {mat[0x02], mat[0x0A], mat[0x12], mat[0x1A], mat[0x22], mat[0x2A], mat[0x32], mat[0x3A]};
  uint8_t mat_3_reordered[] = {mat[0x03], mat[0x0B], mat[0x13], mat[0x1B], mat[0x23], mat[0x2B], mat[0x33], mat[0x3B]};
  uint8_t mat_4_reordered[] = {mat[0x04], mat[0x0C], mat[0x14], mat[0x1C], mat[0x24], mat[0x2C], mat[0x34], mat[0x3C]};
  uint8_t mat_5_reordered[] = {mat[0x05], mat[0x0D], mat[0x15], mat[0x1D], mat[0x25], mat[0x2D], mat[0x35], mat[0x3D]};
  uint8_t mat_6_reordered[] = {mat[0x06], mat[0x0E], mat[0x16], mat[0x1E], mat[0x26], mat[0x2E], mat[0x36], mat[0x3E]};
  uint8_t mat_7_reordered[] = {mat[0x07], mat[0x0F], mat[0x17], mat[0x1F], mat[0x27], mat[0x2F], mat[0x37], mat[0x3F]};

  uint64_t *mat_0_ull = (uint64_t *)mat_0_reordered;
  uint64_t *mat_1_ull = (uint64_t *)mat_1_reordered;
  uint64_t *mat_2_ull = (uint64_t *)mat_2_reordered;
  uint64_t *mat_3_ull = (uint64_t *)mat_3_reordered;
  uint64_t *mat_4_ull = (uint64_t *)mat_4_reordered;
  uint64_t *mat_5_ull = (uint64_t *)mat_5_reordered;
  uint64_t *mat_6_ull = (uint64_t *)mat_6_reordered;
  uint64_t *mat_7_ull = (uint64_t *)mat_7_reordered;

  //next, load values.
  set(*acc_h_ull, *acc_l_ull, *vec_ull,
      *mat_0_ull, *mat_1_ull, *mat_2_ull,
      *mat_3_ull, *mat_4_ull, *mat_5_ull,
      *mat_6_ull, *mat_7_ull);

  //turn the crank.
  step();

  output_struct result;
  //then, get the result.
  get(&result);
  uint16_t *gres = (uint16_t *) &result;

  //rearrange the values to be correct.
  res[0] = gres[4];
  res[1] = gres[5];
  res[2] = gres[6];
  res[3] = gres[7];
  res[4] = gres[0];
  res[5] = gres[1];
  res[6] = gres[2];
  res[7] = gres[3];
}
