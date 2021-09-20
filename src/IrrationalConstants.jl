module IrrationalConstants

using Base: @irrational

export
    twoπ,          # 2π
    fourπ,         # 4π
    halfπ,         # π / 2
    quartπ,        # π / 4
    invπ,          # 1 / π
    twoinvπ,       # 2 / π
    fourinvπ,      # 4 / π
    inv2π,         # 1 / (2π)
    inv4π,         # 1 / (4π)
    sqrt2,         # √2
    sqrt3,         # √3
    sqrtπ,         # √π
    sqrt2π,        # √2π
    sqrt4π,        # √4π
    sqrthalfπ,     # √(π / 2)
    sqrtquartπ,    # √(π / 4)
    invsqrt2,      # 1 / √2
    invsqrt3,      # 1 / √3
    invsqrtπ,      # 1 / √π
    invsqrt2π,     # 1 / √2π
    invsqrt4π,     # 1 / √4π
    invsqrthalfπ,  # 1 / √(π / 2)
    invsqrtquartπ, # 1 / √(π / 4)
    loghalf,       # log(1 / 2)
    logtwo,        # log(2)
    log3,          # log(3)
    logπ,          # log(π)
    log2π,         # log(2π)
    log4π,         # log(4π)
    loghalfπ,      # log(π / 2)
    logquartπ      # log(π / 4)

include("stats.jl")

end # module
