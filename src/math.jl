if VERSION > v"1.6.0"
    _one(x) = one(x)
else
    _one(x) = true
end

for (a,b) in [
    (:twoπ, :inv2π),
    (:fourπ, :inv4π),
    (:halfπ, :twoinvπ),
    (:quartπ, :fourinvπ),
    (:sqrt2π, :invsqrt2π),
    (:sqrt2, :invsqrt2),
    ]
    Ta = Irrational{a}
    Tb = Irrational{b}
    @eval Base.inv(::$Ta) = $b
    @eval Base.literal_pow(::typeof(^), ::$Ta, ::Val{-1}) = $b
    @eval Base.inv(::$Tb) = $a
    @eval Base.literal_pow(::typeof(^), ::$Tb, ::Val{-1}) = $a
    @eval Base.:(*)(::$Ta, ::$Tb) = _one($Ta)
    @eval Base.:(*)(::$Tb, ::$Ta) = _one($Ta)
end
