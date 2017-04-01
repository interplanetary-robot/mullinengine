using Verilog
using Base.Test
using SigmoidNumbers

const TESTSET = [:mullinsim]
should_test(s) = s in TESTSET || "all" in ARGS

include("./general/posit-facts.jl")
include("./general/frac_round.v.jl")
include("./general/exp_trim.v.jl")
include("./decoder/posit_decode.v.jl")
include("./encoder/posit_encode.v.jl")
include("./multiplier/posit_mult.v.jl")
include("./adder/posit_add.v.jl")

#testing suite

if should_test(:basics)
  include("./general/methods_testing.jl")
  include("./decoder/posit_decode_test.jl")
  include("./encoder/posit_encode_test.jl")
  include("./multiplier/posit_mult_test.jl")
  include("./adder/posit_add_test.jl")
end

if should_test(:add8)
  @time test_8bit_add()
  include("./adder/posit_add_test.cg.jl")
end
if should_test(:mul8)
  @time test_8bit_mul()
  include("./multiplier/posit_mult_test.cg.jl")
end

srand(1)

#for restricted printing options

include("./mullinrow/mullinrow.v.jl")

if should_test(:mullin)

  include("./mullinrow/mullintest.jl")
  include("./mullinrow/mullintest-1row.jl")
  include("./mullinrow/mullintest-2row.jl")
  include("./mullinrow/mullintest-8row.jl")

  test_mullin_mul()
  test_mullin_add()
  test_mullin_1row()
  test_mullin_8rows()
end

#mullin sim stuff.
include("mullinrow-c/mullinsim.jl")

if should_test(:mullinsim)
  should_test(:mullin) || include("./mullinrow/mullintest-8row.jl")

  #identity_test_me()
  #identity_test_mullin_8rows()
  include("./mullinrow-c/mullinsim-test.jl")
  include("./mullinrow/mullintest-8row-c.jl")
  test_mullin_8rows_c()
end
