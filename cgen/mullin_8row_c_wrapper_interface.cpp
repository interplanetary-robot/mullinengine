#include <verilated.h>
#include <iostream>
#include "Vmullin_8row_c_wrapper.h"

Vmullin_8row_c_wrapper *mullin_8row_c_wrapper;
vluint64_t main_time = 0;

extern "C" void init(){
  mullin_8row_c_wrapper = new Vmullin_8row_c_wrapper;
}

extern "C" void step(){
  mullin_8row_c_wrapper->eval();
}

extern "C" void finish(){
  mullin_8row_c_wrapper->final();
  delete mullin_8row_c_wrapper;
}

extern "C" void set(uint64_t acc_msb,uint64_t acc_lsb,uint64_t vec_a,uint64_t mtx_0,uint64_t mtx_1,uint64_t mtx_2,uint64_t mtx_3,uint64_t mtx_4,uint64_t mtx_5,uint64_t mtx_6,uint64_t mtx_7){
  mullin_8row_c_wrapper->acc_msb = acc_msb;
  mullin_8row_c_wrapper->acc_lsb = acc_lsb;
  mullin_8row_c_wrapper->vec_a = vec_a;
  mullin_8row_c_wrapper->mtx_0 = mtx_0;
  mullin_8row_c_wrapper->mtx_1 = mtx_1;
  mullin_8row_c_wrapper->mtx_2 = mtx_2;
  mullin_8row_c_wrapper->mtx_3 = mtx_3;
  mullin_8row_c_wrapper->mtx_4 = mtx_4;
  mullin_8row_c_wrapper->mtx_5 = mtx_5;
  mullin_8row_c_wrapper->mtx_6 = mtx_6;
  mullin_8row_c_wrapper->mtx_7 = mtx_7;
}


typedef struct{
  uint64_t res_msb;
  uint64_t res_lsb;
} output_struct;

extern "C" void get(output_struct *value){
    value->res_msb = mullin_8row_c_wrapper->res_msb;
  value->res_lsb = mullin_8row_c_wrapper->res_lsb;
}
    

