using Verilog
using Base.Test

include("./posit-facts.jl")

include("./decoder/posit_decode.v.jl")
include("./decoder/posit_decode_test.jl")

#println(set_inf_zero_bits())
#println(set_one_hot_shift(8))
#println(set_fraction(8))
#println(set_one_hot_regime(8))
#println(set_binary_regime(8))
#println(set_regime(8))
#println(decode_posit(8))

#println(set_inf_zero_bits())
#println(set_one_hot_shift(32))
#println(set_fraction(32))
#println(set_one_hot_regime(32))
#println(set_binary_regime(32))
#println(set_regime(32))
#println(decode_posit(32))


include("./encoder/posit_encode.v.jl")


println(encoding_finalizer(8))
include("./encoder/posit_encode_test.jl")

println(regime_shift(8))
println(one_hot_regime(8))
println(ext_fraction_encoding(8))
println(shifted_fraction_encoding(8))
println(encoding_finalizer(8))
println(encode_posit(8))
