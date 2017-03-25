
typealias State Wire{2:0v}

#get mullin multiplication up in here.
include("mullinmult.v.jl")
include("mullinadd.v.jl")

_F08 = 7:0v
_E08 = 3:0v
_F16 = 15:0v
_E16 = 4:0v

doc"""
  round_accumulator(acc_s, ur_acc_e, ur_acc_f, bits)
  rounds accumulator wires.  fraction input format:

  | MSB...  unrounded fraction  ...LSB |      guard bits      | summary bit |
  |           (bits - 3) bit           |        2 bits        |    1 bit    |

  fraction return format.  The fraction will be rounded to the nearest
  guard bit.

  | MSB...   rounded fraction   ...LSB | guard bit |        zeros           |
  |           (bits - 3) bit           |   1 bit   |        2 bits          |

"""
@verilog function round_accumulator(acc_s::State, ur_acc_e::Wire, ur_acc_f::Wire, bits)
  @suffix                  "_$(bits)bit"
  @input ur_acc_e          range(regime_bits(bits))
  @input ur_acc_f          range(bits)

  #check the last bits of the accumulator fraction to determine if rounding rules
  #apply.
  should_round = (ur_acc_f[2] & ur_acc_f[1]) | (ur_acc_f[1] & ur_acc_f[0])
  #next augment or decrement the fraction as necessary.
  acc_f = Wire(ur_acc_f[msb:2v] + (bits - 2) * Wire(false), Wire(0x0, 2))
  # check to see if we need to change the exponent.  This only happens if
  # we roll over on the fraction value
  # a corner case is if it's negative and the exponent is zero, where we should
  # also do nothing.
  neg_zero_exp = ~(|(ur_acc_e))
  augment_exp = ~(|(acc_f) | neg_zero_exp) & should_round
  #create the augment variable (+/-) 1, or mask it out to all zeros.
  exp_augment_value = Wire((regime_bits(bits) - 1) * acc_s[0], Wire(true)) & (regime_bits(bits) * augment_exp)
  #output the acc_e
  acc_e = ur_acc_e + exp_augment_value

  (acc_e, acc_f)
end

function printer(name, s, e, f, bits)
  println(name, ": P(0x", hex(Unsigned(encode_posit(s[2], s[1], s[0], e, f[msb:3v], f[2:1v], bits)),bits ÷ 4), ")")
end

doc"""
  mullinrow(vec_s, vec_e, vec_f, acc_s, acc_f, acc_e, mul_s, mul_e, mul_f, mode, rownumber, flags)
"""                #state variables           #exponent variables        #fraction variables
function mullinrow(vec::Wire{119:0v}, acc::Wire{191:0v}, mtx::Wire{119:0v}, row)

  #set state variables.
  vec_s = Vector{State}(8)
  vec_e = Vector{Wire{_E08}}(8)
  vec_f = Vector{Wire{_F08}}(8)

  #set accumulator values.
  acc_s = Vector{State}(8)
  acc_e = Vector{Wire{_E16}}(8)
  acc_f = Vector{Wire{_F16}}(8)

  #created unrounded accumulators
  ur_acc_e = Vector{Wire{_E16}}(8)
  ur_acc_f = Vector{Wire{_F16}}(8)

  #set muliplier values.
  mtx_s = Vector{State}(8)
  mtx_e = Vector{Wire{_E08}}(8)
  mtx_f = Vector{Wire{_F08}}(8)

  #assign these lines.  Make sure the top one is the first value.
  for idx = 1:8
    acc_s[idx] = acc[(24 * idx - 1):(24 * idx - 3)v]
    ur_acc_e[idx] = acc[(24 * idx - 4):(24 * idx - 8)v]
    ur_acc_f[idx] = acc[(24 * idx - 9):(24 * idx - 24)v]

    mtx_s[idx] = mtx[(15 * idx - 1):(15 * idx - 3)v]
    mtx_e[idx] = mtx[(15 * idx - 4):(15 * idx - 7)v]
    mtx_f[idx] = mtx[(15 * idx - 8):(15 * idx - 15)v]

    vec_s[idx] = vec[(15 * idx - 1):(15 * idx - 3)v]
    vec_e[idx] = vec[(15 * idx - 4):(15 * idx - 7)v]
    vec_f[idx] = vec[(15 * idx - 8):(15 * idx - 15)v]
  end

  #round the accumulator, populating the 'proper' acc_e and acc_f lines.
  for col = 1:8
    acc_e[col], acc_f[col] = round_accumulator(acc_s[col], ur_acc_e[col], ur_acc_f[col], 16)
  end

  #do the multiplication stage.
  mul_s = Vector{State}(8)
  mul_e = Vector{Wire{_E16}}(8)
  mul_f = Vector{Wire{_F16}}(8)

  #the multiplication routine could "require additional effort for other structures"
  mul_raw_f = Vector{Wire{_F16}}(8)

  for col = 1:8
    #go ahead and do this step always.
    mul_raw_f[col] = vec_f[row] * mtx_f[col]

    #this routine will be moved to a conditional that depends on what type of
    #multiplication routine we're doing.
    mul_s[col], mul_e[col], mul_f[col] = mullin_mul(vec_s[row], vec_e[row], vec_f[row],
                                                    mtx_s[col], mtx_e[col], mtx_f[col],
                                                    mul_raw_f[col], 8, 16)
  end

  #set aside wires that will be used for addition.
  add_s               = Vector{State}(8)
  add_zer             = Vector{SingleWire}(8)
  add_sgn             = Vector{SingleWire}(8)
  add_provisional_exp = Vector{Wire{_E16}}(8)
  add_provisional_frc = Vector{Wire{17:0v}}(8)
  add_e               = Vector{Wire{_E16}}(8)
  add_f               = Vector{Wire{_F16}}(8)

  for col = 1:8

    #perform pre-shifting and adding the fractions for addition.  This may be replaced by a
    #different function in the future, that can accomodate different modes.
    add_sgn[col], add_provisional_exp[col], add_provisional_frc[col] = mullin_frc_add(acc_s[col], acc_e[col], acc_f[col],
                                                                                      mul_s[col], mul_e[col], mul_f[col], 16)

    #check for zeros.
    add_zer[col] = add_zero_checker(acc_s[col][0], acc_e[col], acc_f[col][msb:3v],
                                    mul_s[col][0], mul_e[col], mul_f[col][msb:3v], 16)

    #set various state variables.
    add_s[col]   = mullin_addition_state(acc_s[col], mul_s[col], add_sgn[col], add_zer[col])

    #then do post-shift adjustment stuff.
    add_e[col], add_f[col] = mullin_addition_cleanup(add_sgn[col], add_provisional_exp[col], add_provisional_frc[col], 16)
  end

  Wire([Wire(add_s[idx], add_e[idx], add_f[idx]) for idx in 8:-1:1]...)
end
