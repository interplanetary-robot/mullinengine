using Verilog
using Base.Test


include("./posit-facts.jl")
include("./general/exp_trim.v.jl")
include("./decoder/posit_decode.v.jl")
include("./encoder/posit_encode.v.jl")
include("./multiplier/posit_mult.v.jl")
include("./adder/posit_add.v.jl")

#testing suite
#=
include("./general/methods_testing.jl")
include("./decoder/posit_decode_test.jl")
include("./encoder/posit_encode_test.jl")
include("./multiplier/posit_mult_test.jl")
include("./adder/posit_add_test.jl")

#include("./adder/posit_add_test.cg.jl")  for now, can only test one at a time.
include("./multiplier/posit_mult_test.cg.jl")
@time test_8bit_mul()
@time test_8bit_add()
=#

#work with the mullin engine proper.
include("./mullinrow/mullinrow.v.jl")
include("./mullinrow/mullintest.jl")
