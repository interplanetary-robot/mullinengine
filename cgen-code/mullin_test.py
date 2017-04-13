import numpy as np
import ctypes
from numpy.ctypeslib import ndpointer

# Load C functions into Python
# Make sure to compile test.c into a .so file first
# gcc -shared -fPIC test.c -o test.so
lib = ctypes.cdll['./libpositronickernel.so']

exit()


matrixmult64 = lib['matrixmult64']
matrixmult64.restype = None
matrixmult64.argtypes = [ ndpointer(ctypes.c_double, flags="C_CONTIGUOUS"),
						  ndpointer(ctypes.c_double, flags="C_CONTIGUOUS"),
						  ndpointer(ctypes.c_double, flags="C_CONTIGUOUS"),
						  ndpointer(ctypes.c_double, flags="C_CONTIGUOUS")]


# matrixmult64(double *res, double *mtx, double *vec, double *acc)

res = np.zeros(8).astype(np.float64)
mat = np.random.random(64).astype(np.float64)
vec = np.random.random(8).astype(np.float64)
acc = np.zeros(8).astype(np.float64)

print (type(res))
print (type(res[0]))
print (res.shape)
print ("")

print ("rec: ",res, "\nmat: ",mat , "\nvec: ",vec ,"\nacc: ",acc)
print("---")

matrixmult64(res, mat , vec ,acc )

print("---\n\n")
print ("rec: ",res, "\nmat: ",mat , "\nvec: ",vec ,"\nacc: ",acc)
