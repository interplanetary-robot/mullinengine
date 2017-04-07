extern unsigned short double_to_posit16(double fval);
extern unsigned char  double_to_posit8(double fval);
extern double posit16_to_double(unsigned short pval);

extern "C" void matrixmult64(double *res, double *mtx, double *vec, double *acc);
