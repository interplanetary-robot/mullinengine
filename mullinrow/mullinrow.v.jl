
typealias State Wire{2:0v}

#get mullin multiplication up in here.
include("mullinmult.v.jl")

_F08 = 7:0v
_E08 = 3:0v
_F16 = 15:0v
_E16 = 4:0v

doc"""
  function mullinrow(vec_s, vec_e, vec_f, acc_s, acc_f, acc_e, mul_s, mul_e, mul_f, mode, rownumber, flags)
"""                #state variables           #exponent variables        #fraction variables
function mullinrow(vec_s::State,         vec_e::Wire{_E08},         vec_f::Wire{_F08},
                   acc_s::Vector{State}, acc_e::Vector{Wire{_E16}}, acc_f::Vector{Wire{_E16}},
                   mtx_s::Vector{State}, mtx_e::Vector{Wire{_E08}}, mtx_f::Vector{Wire{_E08}},
                   mode::Wire{0:0v}, rownumber::Integer, flags::Set{Symbol})

  #do the multiplication stage.

  mul_s::Vector{State}(8)
  mul_e::Vector{Wire{_E16}}(8)
  mul_f::Vector{Wire{_F16}}(8)

  #the multiplication routine could "require additional effort for other structures"

  mul_raw_f::Vector{Wire{_F16}}(8)
  mul_fin_f::Vector{Wire{_F16}}(8)
  for idx = 1:8
    #go ahead and do this step always.
    mul_raw_f[idx] = vec_f * mtx_f[idx]

    #this routine will be moved to a conditional that depends on what type of
    #multiplication routine we're doing.
    mul_s[idx], mul_e[idx], mul_fin_f[idx] = mullin_mul(vec_s, vec_e, vec_f,
                                                        mtx_s[idx], mtx_e[idx], mtx_f[idx],
                                                        mul_raw_f[idx], 8, 16)

    #put the results back into the fraction wire..
    mul_f[idx] = Wire(mul_fin_f[idx], Wire(0x00, 3))
  end

  #set aside wires that will be used for addition.
  add_s::Vector{State}(8)
  add_zer::Vector{SingleWire}(8)
  add_sgn::Vector{SingleWire}(8)
  add_provisional_exp::Vector{Wire{_E16}}(8)
  add_provisional_frc::Vector{Wire{_F16}}(8)
  add_exp::Vector{Wire{_E16}}(8)
  add_frc::Vector{Wire{_F16}}(8)

  for idx = 1:8
    #perform pre-shifting and adding the fractions for addition.  This may be replaced by a
    #different function in the future, that can accomodate different modes.
    add_sgn[idx], add_provisional_exp[idx], add_provisional_frc[idx] = mullin_frc_add(acc_s[idx], acc_e[idx], acc_f[idx], mul_s[idx], mul_e[idx], mul_f[idx], 16)

    #check for zeros.
    add_zer[idx] = add_zero_checker(acc_s[idx][0], acc_e[idx], acc_f[idx], mul_s[idx][0], mul_e[idx], mul_f[idx], bits, 3)

    #set various state variables.
    add_s[idx]   = mullin_addition_state(acc_s[idx], mul_s[idx], add_sgn[idx], add_zer[idx])

    #then do post-shift adjustment stuff.
    add_exp[idx], add_frc[idx] = mullin_addition_cleanup()
  end

  #output wires
  out_s::Vector{State}(8)
  out_e::Vector{Wire{_E16}}(8)
  out_f::Vector{Wire{_F16}}(8)
  for idx = 1:8
    #for now, do this.  Later we'll implement other routines here that can
    #accomodate other types of operations.
    out_s[idx], out_e[idx], out_f[idx] = add_s[idx], add_e[idx], add_f[idx]
  end
end
