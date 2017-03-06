using Verilog
using Base.Test

include("./posit-facts.jl")
include("./general/exp_trim.v.jl")
include("./decoder/posit_decode.v.jl")
include("./encoder/posit_encode.v.jl")
include("./multiplier/posit_mult.v.jl")
include("./adder/posit_add.v.jl")

#@test posit_adder(0x05, 0x60, 8) == 0x61

#testing suite
include("./general/methods_testing.jl")
include("./decoder/posit_decode_test.jl")
include("./encoder/posit_encode_test.jl")
include("./multiplier/posit_mult_test.jl")
include("./adder/posit_add_test.jl")

#test_8bit_mul()
#include("./multiplier/posit_mult_test.cg.jl")
test_8bit_add()
