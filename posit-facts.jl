
function bitof(x, y)
  return ((1 << y) & x) != 0
end

regime_bits(n::Integer) = Integer(ceil(log2(n))) + 1
eposit_size(bits::Integer) = regime_bits(bits) + bits
regime_bias(bits) = (bits - 1)
max_biased_exp(bits::Integer) = Unsigned(2 * bits - 3)

gsstring(s::Symbol) = (s == :gs) ? "_gs" : ""
