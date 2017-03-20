using Verilog
using Base.Test
using SigmoidNumbers

include("./posit-facts.jl")
include("./general/frac_round.v.jl")
include("./general/exp_trim.v.jl")
include("./decoder/posit_decode.v.jl")
include("./encoder/posit_encode.v.jl")
include("./multiplier/posit_mult.v.jl")
include("./adder/posit_add.v.jl")


#@test add_theoretical(0b0111, 0b01_11111, 0b0111, 0b01_00000, 8) == 0b1_0111_010_111110

#=
#testing suite
include("./general/methods_testing.jl")
include("./decoder/posit_decode_test.jl")
include("./encoder/posit_encode_test.jl")
include("./multiplier/posit_mult_test.jl")
include("./adder/posit_add_test.jl")
@time test_8bit_add()
@time test_8bit_mul()
include("./adder/posit_add_test.cg.jl")  #for now, can only test one at a time.
#include("./multiplier/posit_mult_test.cg.jl")
#work with the mullin engine proper.
=#

srand(1)

include("./mullinrow/mullinrow.v.jl")
include("./mullinrow/mullintest.jl")
include("./mullinrow/mullintest-1row.jl")
include("./mullinrow/mullintest-2row.jl")

#test_mullin_mul()
test_mullin_add()

#test_mullin_row()
#test_mullin_2rows()
