
#include "mullin-c.h"

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
  unsigned short p_acc[8]
  unsigned char  p_vec[8];
  unsigned char  p_mat[64];
  unsigned short p_res[8];

  //convert the accumulator from double to the 16-bit posit.
  for (idx = 0; idx < 8; idx++){
    p_acc[idx] = double_to_posit16(acc[idx]);
  }

  //convert the vector from double to the 8-bit posit.
  for (idx = 0; idx < 8; idx++){
    p_vec[idx] = double_to_posit8(vec[idx]);
  }

  //repeat the process for the matrix.  honor c's ROW-major convention.
  for (idx = 0; idx < 8; idx++){
    for (jdx = 0; jdx < 8; jdx++){
      p_mat[8 * idx + jdx] = double_to_posit8(mtx[8 * idx + jdx])
    }
  }

  exec_matrix_mult(p_res, p_mat, p_vec, p_acc)

  //populate the result vector.
  for (idx = 0; idx < 8; idx++){
    res[idx] = posit16_to_double(p_res[idx]);
  }
}
/*
// for now, only allow computation on 64-bit types
extern "C" void matrixmult32(float *res, float *mtx, float *vec, float *acc){
  //first allocate the memory that will hold the values.
  //Do this on the stack (for now)
  unsigned short p_acc[8];
  unsigned char  p_vec[8];
  unsigned char  p_mat[8][8];
  unsigned short p_res[8];

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
typedef ull unsigned long long;

void exec_matrix_mult(unsigned short *res, unsigned char *mat, unsigned char *vec, unsigned short *acc){
  //first cast all of these pointers to values
  ull *acc_l_ull = (ull *) acc
  ull *acc_h_ull = acc + 1
  ull *vec_ull = (ull *) vec
  //create the matrix vector indices.  Remember that for c pointers, arithmetic
  // addressing follows the sizeof(type) value.
  ull *mat_0_ull = ((ull *) mat) + 0
  ull *mat_1_ull = ((ull *) mat) + 1
  ull *mat_2_ull = ((ull *) mat) + 2
  ull *mat_3_ull = ((ull *) mat) + 3
  ull *mat_4_ull = ((ull *) mat) + 4
  ull *mat_5_ull = ((ull *) mat) + 5
  ull *mat_6_ull = ((ull *) mat) + 6
  ull *mat_7_ull = ((ull *) mat) + 7

  //next, load values.
  set(*acc_h_ull, *acc_l_ull, *vec_ull,
      *mat_0_ull, *mat_1_ull, *mat_2_ull,
      *mat_3_ull, *mat_4_ull, *mat_5_ull,
      *mat_6_ull, *mat_7_ull)

  //turn the crank.
  step()

  //then, get the result.
  get((output_struct *) *res)
}
