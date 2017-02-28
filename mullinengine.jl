using Verilog
using Base.Test

include("./posit-facts.jl")
include("./decoder/posit_decode.v.jl")
include("./encoder/posit_encode.v.jl")
include("./multiplier/posit_mult.v.jl")

#=
res = posit_multiplier(0x29, 0x39, 8, 8)
println(bits(res)[end-7:end])

exit()
=#

#testing suite
include("./decoder/posit_decode_test.jl")
include("./encoder/posit_encode_test.jl")
include("./multiplier/posit_mult_test.jl")
