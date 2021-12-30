# lazy-initialized LambertW Omega at 256-bit precision
const lambertw_Omega_BigFloat256 = Ref{BigFloat}()

# compute BigFloat Omega constant at arbitrary precision
function compute_lambertw_Omega()
    # initialize lambertw_Omega_BigFloat256
    isassigned(lambertw_Omega_BigFloat256) ||
        (lambertw_Omega_BigFloat256[] = BigFloat("0.5671432904097838729999686622103555497538157871865125081351310792230457930866845666932194"))
    o = lambertw_Omega_BigFloat256[] # initial value
    precision(BigFloat) <= 256 && return o
    # iteratively improve the precision of the constant
    myeps = eps(BigFloat)
    for _ in 1:100
        o_ = (1 + o) / (1 + exp(o))
        abs(o - o_) <= myeps && break
        o = o_
    end
    return o
end

@irrational lambertw_Ω 0.567143290409783872999968662210355 compute_lambertw_Omega()
const lambertw_Omega = lambertw_Ω # ASCII alias

"""
Lambert's Omega (Ω) constant, such that Ω exp(Ω) = 1.

*W(Ω) = 1*, where *W(t) = t exp(t)* is the *Lambert's W function*.

# See
https://en.wikipedia.org/wiki/Omega_constant
"""
lambertw_Ω