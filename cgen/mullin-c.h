extern "C" unsigned short double_to_posit16(double fval);
extern "C" unsigned char  double_to_posit8(double fval);
extern "C" double posit16_to_double(unsigned short pval);

extern "C" void matrixmult64(double *res, double *mtx, double *vec, double *acc);

////////////////////////////////////////////////////////////////////////////////

typedef struct{
  unsigned long long res_msb;
  unsigned long long res_lsb;
} output_struct;

//functions that are coming in from the wrappers.
extern "C" void init();
extern "C" void step();
extern "C" void finish();
extern "C" void set(unsigned long long acc_msb,unsigned long long acc_lsb,unsigned long long vec_a,unsigned long long mtx_0,unsigned long long mtx_1,unsigned long long mtx_2,unsigned long long mtx_3,unsigned long long mtx_4,unsigned long long mtx_5,unsigned long long mtx_6,unsigned long long mtx_7);
extern "C" void get(output_struct *value);
