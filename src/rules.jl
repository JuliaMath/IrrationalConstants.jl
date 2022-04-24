## Square
SQUARE_PAIRS = (
    (sqrt2, 2.0),
    (sqrt3, 3.0),
    (sqrtπ, π),
    (sqrt2π, twoπ),
    (sqrt4π, fourπ),
    (sqrthalfπ, halfπ),
    (invsqrt2, 0.5),
    (invsqrtπ, invπ),
    (invsqrt2π, inv2π),
)
for (a,b) in SQUARE_PAIRS
    Base.:(*)(::typeof(a), ::typeof(a)) = b
    Base.literal_pow(::typeof(^), ::typeof(a), ::Val{2}) = b
end

## Inverse
INVERSE_PAIRS = (
    (π, invπ),
    (twoπ, inv2π),
    (twoinvπ, halfπ),
    (quartπ, fourinvπ),
    (fourπ, inv4π),
    (sqrt2π, invsqrt2π),
    (sqrt2, invsqrt2),
    (sqrtπ, invsqrtπ),
)
for (a,b) in INVERSE_PAIRS
    if a !== π  # Avoid type piracy
        Base.inv(::typeof(a)) = b
        Base.literal_pow(::typeof(^), ::typeof(a), ::Val{-1}) = b
    end
    Base.inv(::typeof(b)) = a
    Base.literal_pow(::typeof(^), ::typeof(b), ::Val{-1}) = a
    Base.:(*)(::typeof(a), ::typeof(b)) = one(Irrational)
end

## Triangular
Base.sin(::Irrational{:twoπ}) = 0.0
Base.cos(::Irrational{:twoπ}) = 1.0
Base.sincos(::Irrational{:twoπ}) = (0.0, 1.0)
Base.sin(::Irrational{:fourπ}) = 0.0
Base.cos(::Irrational{:fourπ}) = 1.0
Base.sincos(::Irrational{:fourπ}) = (0.0, 1.0)
Base.sin(::Irrational{:quartπ}) = invsqrt2
Base.cos(::Irrational{:quartπ}) = invsqrt2
Base.sincos(::Irrational{:quartπ}) = (invsqrt2, invsqrt2)
Base.sin(::Irrational{:halfπ}) = 1.0
Base.cos(::Irrational{:halfπ}) = 0.0
Base.sincos(::Irrational{:halfπ}) = (1.0, 0.0)

## Exponential
Base.exp(::Irrational{:loghalf}) = 0.5
Base.exp(::Irrational{:logtwo}) = 2.0
Base.exp(::Irrational{:logten}) = 10.0
Base.exp(::Irrational{:logπ}) = π
Base.exp(::Irrational{:log2π}) = twoπ
Base.exp(::Irrational{:log4π}) = fourπ

## Logarithm
# Base.log(::Irrational{:π}) = logπ  # Avoid type piracy
Base.log(::Irrational{:twoπ}) = log2π
Base.log(::Irrational{:fourπ}) = log4π
