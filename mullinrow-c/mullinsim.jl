#prototyping the mullinrow-c thing.

using FixedSizeArrays

#won't bother making these bitstypes since the mullinsim is supposed to be like
#a c library, and c doesn't make a distinction between ints and bits.
typealias MStats  UInt8
typealias MExp    Int8
typealias MFrac8  UInt8
typealias MFrac16 UInt16
typealias MGS     UInt8

type mullin_buff8
  s::MStats
  e::MExp
  f::MFrac8
end

type mullin_buff16
  s::MStats
  e::MExp
  f::MFrac16
  g::MGS
end

typealias mullin_row_simulator Mat{8,8,mullin_buff8}

P8 = Posit{8,0}

#leading_zeros/leading_ones emits a 64-bit integer.  This makes sure it emits an 8-bit integer
lz8(v::UInt8) = reinterpret(Int8, UInt8((reinterpret(UInt64, leading_zeros(v)) & 0x0000_0000_0000_00FF)))
lo8(v::UInt8) = reinterpret(Int8, UInt8((reinterpret(UInt64, leading_ones(v))  & 0x0000_0000_0000_00FF)))

#create a function which takes a posit and breaks it down into buffer components.
#This function is just about as optimized as it gets.
function p2b8(posit::UInt8)
  zinf = (posit & 0x7F) == 0x00
  sgn = (posit & 0x80) != 0x00
  s::MStats    = (reinterpret(UInt8, zinf & sgn) << 2)    |
                 (reinterpret(UInt8, zinf & (!sgn)) << 1) |
                 (reinterpret(UInt8, sgn))
  inv          = (posit & 0x40) != 0x00
  zshift::Int8 = lz8(posit & 0x7F)
  oshift::Int8 = lo8(posit | 0x80)
  shft::Int8   = inv ? oshift : zshift
  si           = sgn $ inv
  e::MExp      = Int8(7) + (si ? (shft - Int8(2)) : (Int8(1) - shft))
  f::MFrac8    = posit << (shft + Int8(1))
  mullin_buff8(s,e,f)
end

#create a function which takes a 16-bit posit buffer and returns an *8 bit*
#value.
function b16_2p8(buff::mullin_buff16)::UInt8
  #override for zeros and infs, or do appropriate calculations.
  if (buff.s & 0x6 != 0)
    inf = (buff.s & 0x04 != 0)
    zer = (buff.s & 0x02 != 0)

    #override codes
    (inf & zer) && throw(SigmoidNumbers.NaNError())
    inf && return 0x80
    zer && return 0x00
  end
  local sgn::Bool = reinterpret(Bool, (buff.s & 0x01))
  #calculate the exponent.  Rebias around the 8-bit bias value (15 -> 7)
  #trim the exponent as needed.
  local shift::Int64
  local prefix::UInt8

  if sgn  #presume negative
    #get parameters based on rebiased exponent
    if buff.e > 13
      shift = buff.e - 14
      prefix = 0x00
    else
      shift = 13 - buff.e
      prefix = 0x80
    end
  else
    if buff.e > 14
      shift = buff.e - 15
      prefix = 0x80
    else
      shift = 14 - buff.e
      prefix = 0x00
    end
  end

  #println("shift:", shift)

  #next, construct the fraction by shifting to the right nine positions, then
  #merging with the prefix.
  local frac8::UInt8 = (buff.f >> 9) | prefix

  #this needs to be an *arithmetic* shift.
  local constructed_8::UInt8 = frac8 >>> shift
  #figure out the guard and summary bits.
  local shiftbit::UInt16 = (0x0001 << (shift + 8))
  inner = (constructed_8 & 0x01) != 0
  guard = (shift == 0) ? (buff.g & 0x2 != 0) : ((buff.f & shiftbit)  != 0)
  summary = (buff.f & (shiftbit - one(UInt16))) != 0
  constructed_8 += (inner & guard) | (guard & summary)
  if sgn
    constructed_8 == 0x00 && return (0x81)
    constructed_8 == 0x80 && return (0xFF)
    return constructed_8 | 0x80
  else
    constructed_8 == 0x00 && return (0x01)
    constructed_8 == 0x80 && return (0x7F)
    return constructed_8 & 0x7F
  end
end

function create_mullin_simulator(m::Matrix{P8})
  @assert shape(m) == (8,8)
  #broadcast the p2b over the simulator.
  mullin_row_simulator(p2b8.(m))
end
