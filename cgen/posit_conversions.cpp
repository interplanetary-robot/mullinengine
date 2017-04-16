
#include <stdbool.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>

////////////////////////////////////////////////////////////////////////////////
// DOUBLE PRECISION CONVERSIONS
////////////////////////////////////////////////////////////////////////////////

extern "C" uint16_t double_to_posit16(double fval){
  //infinity and NaN checks:
  if (fval == INFINITY) return 0x8000;
  if (fval == 0.0) return 0x0000;

  //do a surreptitious conversion from double precision to UInt64
  uint64_t *ival = (uint64_t *) &fval;

  bool signbit = ((0x8000000000000000LL & (*ival)) != 0);
  //capture the exponent value
  int16_t exponent = (((0x7FF0000000000000LL & (*ival)) >> 52) - 1023);

  exponent = (exponent > 14) ? 14 : exponent;
  exponent = (exponent < -15) ? -15 : exponent;

  //use an uint64_t value as an intermediary store for
  //all off the fraction bits.  Mask out the top two bits.
  uint64_t frac = ((*ival) << 10) & (0x3FFFFFFFFFFFFFFFLL);

  int16_t shift = 0;
  if (exponent >= 0) {
    shift = 1 + exponent;
    frac |= 0x8000000000000000LL;
  } else {
    shift = -exponent;
    frac |= 0x4000000000000000LL;
  }

  //let's hope the compiler isn't dumb as rocks here.
  frac = (uint64_t)(((int64_t) frac) >> shift);

  bool guard = (frac & 0x0000800000000000LL) != 0;
  bool summ  = (frac & 0x00007FFFFFFFFFFFLL) != 0;
  bool inner = (frac & 0x0001000000000000LL) != 0;

  //mask out the top bit
  frac &= 0x7FFFFFFFFFFFFFFFLL;

  //augment the frac variable in the event it needs be augmented.
  frac += ((guard && inner) || (guard && summ)) ? 0x0001000000000000LL : 0x0000000000000000LL;

  uint16_t res = frac >> 48;

  //invert if negative.
  return (signbit ? -res : res);
}

extern "C" uint8_t double_to_posit8(double fval){
  //infinity and NaN checks:
  if (fval == INFINITY) return 0x80;
  if (fval == 0.0) return 0x00;

  //do a surreptitious conversion from double precision to UInt64
  uint64_t *ival = (uint64_t *) &fval;

  bool signbit = ((0x8000000000000000LL & (*ival)) != 0);
  //capture the exponent value
  int16_t exponent = (((0x7FF0000000000000LL & (*ival)) >> 52) - 1023);

  exponent = (exponent > 6) ? 6 : exponent;
  exponent = (exponent < -7) ? -7 : exponent;

  //use an uint64_t value as an intermediary store for
  //all off the fraction bits.  Mask out the top two bits.
  uint64_t frac = ((*ival) << 10) & (0x3FFFFFFFFFFFFFFFLL);

  int16_t shift = 0;
  if (exponent >= 0) {
    shift = 1 + exponent;
    frac |= 0x8000000000000000LL;
  } else {
    shift = -exponent;
    frac |= 0x4000000000000000LL;
  }

  //let's hope the compiler isn't dumb as rocks here.
  frac = (uint64_t)(((int64_t) frac) >> shift);

  bool guard = (frac & 0x0080000000000000LL) != 0;
  bool summ  = (frac & 0x007FFFFFFFFFFFFFLL) != 0;
  bool inner = (frac & 0x0100000000000000LL) != 0;

  //mask out the top bit
  frac &= 0x7FFFFFFFFFFFFFFFLL;

  //augment the frac variable in the event it needs be augmented.
  frac += ((guard && inner) || (guard && summ)) ? 0x0100000000000000LL : 0x0000000000000000LL;

  uint8_t res = frac >> 56;

  //invert if negative.
  return (signbit ? -res : res);
}

extern "C" double posit16_to_double(uint16_t posit){
  //check for infs and zeros.
  if (posit == 0x8000) return INFINITY;
  if (posit == 0x0000) return 0.0;

  //first determine the sign.
  bool negative = (posit & 0x8000) != 0;
  //if it's negative, fix the sign.
  uint16_t pposit = negative ? -posit : posit;

  //ascertain if it's inverted.
  bool inverted = (pposit & 0x4000) == 0;

  //note that the clz/clo intrinsics operate on 32-bit data types.
  uint16_t shift;
  uint16_t exponent;
  if (inverted){
    shift = __builtin_clz(pposit) - 16;
    exponent = 1024 - shift;
    shift += 37;
  } else {
    uint16_t z_posit = ~pposit & 0x7FFF;
    //__builtin_clz has "undefined" state for a value of 0.  W.T.F.
    shift = (z_posit == 0) ? 16 : __builtin_clz(z_posit) - 16;
    exponent = 1021 + shift;
    shift += 37;
  }

  //create an unsigned integer to hold the values.
  int64_t result;
  result = (negative ? 0x8000000000000000LL : 0LL) | (((int64_t) exponent) << 52) |
    ((((int64_t) pposit) << shift) & 0x000FFFFFFFFFFFFFLL);
  //violently convert to a double.
  return *((double *) &result);
}

////////////////////////////////////////////////////////////////////////////////
// SINGLE PRECISION CONVERSIONS
////////////////////////////////////////////////////////////////////////////////

extern "C" uint16_t single_to_posit16(float fval){
  //infinity and NaN checks:
  if (fval == INFINITY) return 0x8000;
  if (fval == 0.0) return 0x0000;

  //do a surreptitious conversion from double precision to UInt32
  uint32_t *ival = (uint32_t *) &fval;

  bool signbit = ((0x80000000L & (*ival)) != 0);
  //capture the exponent value

  int16_t exponent = (((0x7F800000L & (*ival)) >> 23) - 127);

  exponent = (exponent > 14) ? 14 : exponent;
  exponent = (exponent < -15) ? -15 : exponent;

  //use an uint32_t value as an intermediary store for
  //all off the fraction bits.  Mask out the top two bits.
  uint32_t frac = ((*ival) << 7) & (0x3FFFFFFFL);

  int16_t shift = 0;
  if (exponent >= 0) {
    shift = 1 + exponent;
    frac |= 0x80000000L;
  } else {
    shift = -exponent;
    frac |= 0x40000000L;
  }

  //let's hope the compiler isn't dumb as rocks here.
  frac = (uint32_t)(((int32_t) frac) >> shift);

  bool guard = (frac & 0x00008000L) != 0;
  bool summ  = (frac & 0x00007FFFL) != 0;
  bool inner = (frac & 0x00010000L) != 0;

  //mask out the top bit
  frac &= 0x7FFFFFFFL;

  //augment the frac variable in the event it needs be augmented.
  frac += ((guard && inner) || (guard && summ)) ? 0x00010000L : 0x00000000L;

  uint16_t res = frac >> 16;

  //invert if negative.
  return (signbit ? -res : res);
}

extern "C" uint8_t single_to_posit8(float fval){
  //infinity and NaN checks:
  if (fval == INFINITY) return 0x80;
  if (fval == 0.0) return 0x00;

  //do a surreptitious conversion from double precision to UInt64
  uint32_t *ival = (uint32_t *) &fval;

  bool signbit = ((0x80000000L & (*ival)) != 0);
  //capture the exponent value
  int16_t exponent = (((0x7F800000L & (*ival)) >> 23) - 127);

  exponent = (exponent > 6) ? 6 : exponent;
  exponent = (exponent < -7) ? -7 : exponent;

  //use an uint32_t value as an intermediary store for
  //all off the fraction bits.  Mask out the top two bits.
  uint32_t frac = ((*ival) << 10) & (0x3FFFFFFFL);

  int16_t shift = 0;
  if (exponent >= 0) {
    shift = 1 + exponent;
    frac |= 0x80000000L;
  } else {
    shift = -exponent;
    frac |= 0x40000000L;
  }

  //let's hope the compiler isn't dumb as rocks here.
  frac = (uint32_t)(((int32_t) frac) >> shift);

  bool guard = (frac & 0x00800000L) != 0;
  bool summ  = (frac & 0x007FFFFFL) != 0;
  bool inner = (frac & 0x01000000L) != 0;

  //mask out the top bit
  frac &= 0x7FFFFFFFL;

  //augment the frac variable in the event it needs be augmented.
  frac += ((guard && inner) || (guard && summ)) ? 0x01000000L : 0x00000000L;

  uint8_t res = frac >> 24;

  //invert if negative.
  return (signbit ? -res : res);
}

extern "C" float posit16_to_single(uint16_t posit){
  //check for infs and zeros.
  if (posit == 0x8000) return INFINITY;
  if (posit == 0x0000) return 0.0;

  //first determine the sign.
  bool negative = (posit & 0x8000) != 0;
  //if it's negative, fix the sign.
  uint16_t pposit = negative ? -posit : posit;

  //ascertain if it's inverted.
  bool inverted = (pposit & 0x4000) == 0;

  //note that the clz/clo intrinsics operate on 32-bit data types.
  uint16_t shift;
  uint16_t exponent;
  if (inverted){
    shift = __builtin_clz(pposit) - 16;
    exponent = 128 - shift;
    shift += 8;
  } else {
    uint16_t z_posit = ~pposit & 0x7FFF;
    //__builtin_clz has "undefined" state for a value of 0.  W.T.F.
    shift = (z_posit == 0) ? 16 : __builtin_clz(z_posit) - 16;
    exponent = 125 + shift;
    shift += 8;
  }

  //create an unsigned integer to hold the values.
  uint32_t result;
  result = (negative ? 0x80000000L : 0L) | (((uint32_t) exponent) << 23) |
    ((((uint32_t) pposit) << shift) & 0x007FFFFFL);
  //violently convert to a double.
  return *((float *) &result);
}
