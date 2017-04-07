#mullintest.jl  -test stuff for mullin engine components

################################################################################
#test mullin mul component

doc"""
  wraps mullin_mul so that you can call it as fused wires.
"""
@verilog function mullin_mul_wrapper(lhs::Wire{7:0v}, rhs::Wire{7:0v})
  lhs_dec = decode_posit(lhs, 8)
  rhs_dec = decode_posit(rhs, 8)

  lhs_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3))
  rhs_frc = Wire(rhs_dec[4:0v], Wire(0x0, 3))

  #generate a the muliply fraction, like the mullin engine does.
  mul_frc = Wire(lhs_dec[4:0v], Wire(0x0, 3)) * Wire(rhs_dec[4:0v], Wire(0x0, 3))

  #perform mullin_mul
  mul_s, mul_e, mul_f = mullin_mul(lhs_dec[11:9v], lhs_dec[8:5v], lhs_frc,
                                   rhs_dec[11:9v], rhs_dec[8:5v], rhs_frc,
                                   mul_frc, 8, 16)

  mul_gs = Wire(0x0, 2)

  rhs_dec = encode_posit(mul_s[2], mul_s[1], mul_s[0], mul_e, mul_f[msb:3v], mul_gs, 16)
end

function test_mullin_mul()
  #first make sure this makes sense at all.

  test_one = 0x4000
  test_res = mullin_mul_wrapper(test_one >> 8, test_one >> 8) << 48
  @test test_res == 0x4000_0000_0000_0000

  #test this comprehensively.
  print("testing mullin multiplier...")
  @time for lhs = 0x0000:0x0100:0xFF00
    for rhs = 0x0000:0x0100:0xFF00
      lhs_s = Posit{16,0}(lhs)
      rhs_s = Posit{16,0}(rhs)
      try
        resp = lhs_s * rhs_s

        res = mullin_mul_wrapper(lhs >> 8, rhs >> 8) << 48

        @test (reinterpret(Posit{16,0},res), lhs, rhs) == (resp, lhs, rhs)
      catch e
        #skip over NaNs.
        if isa(e,SigmoidNumbers.NaNError)
          continue
        end

        rethrow()
      end
    end
  end
  println("OK.")
end

################################################################################
# testing mullin add component

doc"""
  wraps mullin_add so that you can call it as fused wires.
"""
@verilog function mullin_add_wrapper(lhs::Wire{15:0v}, rhs::Wire{15:0v})

  lhs_dec = decode_posit(lhs, 16)
  rhs_dec = decode_posit(rhs, 16)

  lhs_s = lhs_dec[20:18v]
  rhs_s = rhs_dec[20:18v]

  lhs_e = lhs_dec[17:13v]
  rhs_e = rhs_dec[17:13v]

  lhs_f = Wire(lhs_dec[12:0v], Wire(0x0, 3))
  rhs_f = Wire(rhs_dec[12:0v], Wire(0x0, 3))

  #perform pre-shifting and adding the fractions for addition.  This may be replaced by a
  #different function in the future, that can accomodate different modes.
  add_sgn, add_provisional_exp, add_provisional_frc = mullin_frc_add(lhs_s, lhs_e, lhs_f,
                                                                     rhs_s, rhs_e, rhs_f, 16)

  #check for zeros.
  add_zer = add_zero_checker(lhs_s, lhs_e, lhs_f[msb:3v],
                             rhs_s, rhs_e, rhs_f[msb:3v], 16)

  #set result state variables.
  add_s   = mullin_addition_state(lhs_s, rhs_s, add_sgn, add_zer)

  #then do post-shift adjustment stuff.
  add_exp, add_frc = mullin_addition_cleanup(add_sgn, add_provisional_exp, add_provisional_frc, 16)

  #for analysis.  In the "actual" function this will be put back into the accumulator.
  rhs_dec = encode_posit(add_s[2], add_s[1], add_s[0], add_exp, add_frc[msb:3v], add_frc[2:1v], 16)
end

function test_mullin_add()
  #test this comprehensively.
  print("testing mullin adder...")
  @time for lhs = 0x0000:0x0100:0xFF00
    for rhs = 0x0000:0x0100:0xFF00
      res = mullin_add_wrapper(lhs, rhs) << 48

      lhs_s = Posit{16,0}(lhs)
      rhs_s = Posit{16,0}(rhs)

      try
        resp = lhs_s + rhs_s

        res = mullin_add_wrapper(lhs, rhs) << 48

        @test (reinterpret(Posit{16,0},res), lhs, rhs) == (resp, lhs, rhs)
      catch e
        #skip over NaNs.
        if isa(e,SigmoidNumbers.NaNError)
          continue
        end

        rethrow()
      end
    end
  end
  println("OK.")
end
