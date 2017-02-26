using Verilog
using Base.Test

include("./posit-facts.jl")

include("./decoder/posit_decode.v.jl")
include("./decoder/posit_decode_test.jl")

include("./encoder/posit_encode.v.jl")
include("./encoder/posit_encode_test.jl")

include("./multiplier/posit_mult.v.jl")
