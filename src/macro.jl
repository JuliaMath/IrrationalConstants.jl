# We define a custom subtype of `AbstractIrrational` and
# define methods for it that are not generalized yet to `AbstractIrrational`
# in https://github.com/JuliaLang/julia/blob/e536c77f4dc693aafc48af910b4fd86b487e900d/base/irrationals.jl

abstract type IrrationalConstant <: AbstractIrrational end

# TODO: Remove definitions if they become available for `AbstractIrrational` in Base
# Ref https://github.com/JuliaLang/julia/pull/48768
function Base.show(io::IO, ::MIME"text/plain", x::IrrationalConstant)
    if get(io, :compact, false)::Bool
        print(io, x)
    else
        print(io, x, " = ", string(float(x))[1:min(end,15)], "...")
    end
end

Base.:(==)(::T, ::T) where {T<:IrrationalConstant} = true
Base.:<(::T, ::T) where {T<:IrrationalConstant} = false
Base.:<=(::T, ::T) where {T<:IrrationalConstant} = true
Base.hash(x::IrrationalConstant, h::UInt) = 3*objectid(x) - h
Base.round(x::IrrationalConstant, r::RoundingMode) = round(float(x), r)

# definitions for AbstractIrrational added in https://github.com/JuliaLang/julia/pull/34773
if VERSION < v"1.5.0-DEV.301"
    Base.zero(::IrrationalConstant) = false
    Base.zero(::Type{<:IrrationalConstant}) = false

    Base.one(::IrrationalConstant) = true
    Base.one(::Type{<:IrrationalConstant}) = true
end

# definition for AbstractIrrational added in https://github.com/JuliaLang/julia/pull/31068
if VERSION < v"1.2.0-DEV.337"
    Base.inv(x::IrrationalConstant) = 1/x
end

"""
    @irrational sym val def [T]
    @irrational(sym, val, def[, T])

Define a new singleton type `T` representing an irrational constant as subtype of
`IrrationalConstants.IrrationalConstant <: AbstractIrrational` with an instance named `sym`, pre-computed `Float64` value `val`,
and arbitrary-precision definition in terms of `BigFloat`s given by the expression `def`.

As default, `T` is set to `sym` with the first character converted to uppercase.

An `AssertionError` is thrown when either `big(def) isa BigFloat` or `Float64(val) == Float64(def)`
returns `false`.

# Examples

```jldoctest
julia> IrrationalConstants.@irrational(twoπ, 6.2831853071795864769, 2*big(π))

julia> twoπ
twoπ = 6.2831853071795...

julia> IrrationalConstants.@irrational sqrt2  1.4142135623730950488  √big(2)

julia> sqrt2
sqrt2 = 1.4142135623730...

julia> IrrationalConstants.@irrational halfτ  3.14159265358979323846  pi

julia> halfτ
halfτ = 3.1415926535897...

julia> IrrationalConstants.@irrational sqrt2  1.4142135623730950488  big(2)
ERROR: AssertionError: big($(Expr(:escape, :sqrt2))) isa BigFloat

julia> IrrationalConstants.@irrational sqrt2  1.41421356237309  √big(2)
ERROR: AssertionError: Float64($(Expr(:escape, :sqrt2))) == Float64(big($(Expr(:escape, :sqrt2))))
```
"""
macro irrational(sym, val, def, T=Symbol(uppercasefirst(string(sym))))
    esym = esc(sym)
    qsym = esc(Expr(:quote, sym))
    eT = esc(T)
    bigconvert = if VERSION < v"1.1.0-DEV.683"
        # support older Julia versions prior to https://github.com/JuliaLang/julia/pull/29157
        isa(def,Symbol) ? quote
            function Base.BigFloat(::$eT)
                c = BigFloat()
                ccall(($(string("mpfr_const_", def)), :libmpfr),
                      Cint, (Ref{BigFloat}, Int32), c, Base.MPFR.ROUNDING_MODE[])
                return c
            end
        end : quote
            Base.BigFloat(::$eT) = $(esc(def))
        end
    else
        # newer Julia versions
        isa(def, Symbol) ? quote
            function Base.BigFloat(::$eT, r::Base.MPFR.MPFRRoundingMode=Base.MPFR.ROUNDING_MODE[]; precision=precision(BigFloat))
                c = BigFloat(; precision=precision)
                ccall(($(string("mpfr_const_", def)), :libmpfr),
                      Cint, (Ref{BigFloat}, Base.MPFR.MPFRRoundingMode), c, r)
                return c
            end
        end : quote
            function Base.BigFloat(::$eT; precision=precision(BigFloat))
                setprecision(BigFloat, precision) do
                    $(esc(def))
                end
            end
        end
    end
    quote
        struct $T <: IrrationalConstant end
        const $esym = $eT()
        $bigconvert
        Base.Float64(::$eT) = $val
        Base.Float32(::$eT) = $(Float32(val))
        Base.show(io::IO, ::$eT) = print(io, $qsym)
        @assert isa(big($esym), BigFloat)
        @assert Float64($esym) == Float64(big($esym))
        @assert Float32($esym) == Float32(big($esym))
    end
end
