# compute BigFloat Omega constant at arbitrary precision
function compute_lambertw_Omega()
    o = BigFloat("0.5671432904097838729999686622103555497538157871865125081351310792230457930866845666932194")
    precision(o) <= 256 && return o
    # iteratively improve the precision
    # see https://en.wikipedia.org/wiki/Omega_constant#Computation
    myeps = eps(BigFloat)
    for _ in 1:1000
        o_ = (1 + o) / (1 + exp(o))
        abs(o - o_) <= myeps && return o
        o = o_
    end
    @warn "Omega precision is less than current BigFloat precision ($(precision(BigFloat)))"
    return o
end

@irrational lambertw_Omega 0.567143290409783872999968662210355 compute_lambertw_Omega()

module LambertW

"""
Lambert's Omega (*Ω*) constant.

Lambert's *Ω* is the solution to *W(Ω) = 1* equation,
where *W(t) = t exp(t)* is the
[Lambert's *W* function](https://en.wikipedia.org/wiki/Lambert_W_function).

# See also
  * https://en.wikipedia.org/wiki/Omega_constant
  * [`lambertw()`][@ref SpecialFunctions.lambertw]
"""
const Ω = parentmodule(@__MODULE__).lambertw_Omega
const Omega = parentmodule(@__MODULE__).lambertw_Omega # ASCII alias

end
