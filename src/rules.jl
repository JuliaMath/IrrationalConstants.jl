## Multiplication
Base.:*(::Irrational{:sqrt2}, ::Irrational{:sqrt2}) = 2.0
Base.:*(::Irrational{:sqrt3}, ::Irrational{:sqrt3}) = 3.0
Base.:*(::Irrational{:sqrtπ}, ::Irrational{:sqrtπ}) = π
Base.:*(::Irrational{:sqrt2π}, ::Irrational{:sqrt2π}) = twoπ
Base.:*(::Irrational{:sqrt4π}, ::Irrational{:sqrt4π}) = fourπ
Base.:*(::Irrational{:sqrt4π}, ::Irrational{:sqrt4π}) = fourπ

## Inverse
Base.inv(::Irrational{:invπ}) = π
Base.inv(::Irrational{:twoinvπ}) = halfπ
# Base.inv(::Irrational{:fourinvπ}) = π/4  # This is not necessary because the return value will be approximated floating-point number.
Base.inv(::Irrational{:inv2π}) = twoπ
Base.inv(::Irrational{:inv4π}) = fourπ
Base.inv(::Irrational{:invsqrt2}) = sqrt2
Base.inv(::Irrational{:invsqrtπ}) = sqrtπ
Base.inv(::Irrational{:invsqrt2π}) = sqrt2π
# Base.inv(::Irrational{:π}) = invπ  # Avoid type piracy
Base.inv(::Irrational{:twoπ}) = inv2π
Base.inv(::Irrational{:halfπ}) = twoinvπ
Base.inv(::Irrational{:fourπ}) = inv4π
Base.inv(::Irrational{:sqrt2}) = invsqrt2
Base.inv(::Irrational{:sqrtπ}) = sqrtπ
Base.inv(::Irrational{:sqrt2π}) = sqrt2π

## Triangular
Base.sin(::Irrational{:twoπ}) = 0.0
Base.cos(::Irrational{:twoπ}) = 1.0
Base.sincos(::Irrational{:twoπ}) = (0.0, 1.0)
Base.sin(::Irrational{:fourπ}) = 0.0
Base.cos(::Irrational{:fourπ}) = 1.0
Base.sincos(::Irrational{:fourπ}) = (0.0, 1.0)

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
