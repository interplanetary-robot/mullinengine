#include <stdint.h>

extern "C" uint16_t double_to_posit16(double fval);
extern "C" uint8_t  double_to_posit8(double fval);
extern "C" double posit16_to_double(uint16_t pval);

extern "C" void matrixmult64(double *res, double *mtx, double *vec, double *acc);

////////////////////////////////////////////////////////////////////////////////

typedef struct{
  uint64_t res_msb;
  uint64_t res_lsb;
} output_struct;

//functions that are coming in from the wrappers.
extern "C" void init();
extern "C" void step();
extern "C" void finish();
extern "C" void set(uint64_t acc_msb,uint64_t acc_lsb,uint64_t vec_a,uint64_t mtx_0,uint64_t mtx_1,uint64_t mtx_2,uint64_t mtx_3,uint64_t mtx_4,uint64_t mtx_5,uint64_t mtx_6,uint64_t mtx_7);
extern "C" void get(output_struct *value);
