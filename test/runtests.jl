using IrrationalConstants
using Documenter
using Test

@testset "k*pi" begin
    @test isapprox(2*pi, twoπ)
    @test isapprox(4*pi, fourπ)
    @test isapprox(pi/2, halfπ)
    @test isapprox(pi/4, quartπ)
end

@testset "k/pi" begin
    @test isapprox(1/pi, invπ)
    @test isapprox(2/pi, twoinvπ)
    @test isapprox(4/pi, fourinvπ)
end

@testset "1/(k*pi)" begin  
    @test isapprox(1/(2pi), inv2π)
    @test isapprox(1/(4pi), inv4π)
end

@testset "sqrt" begin
    @test isapprox(sqrt(2), sqrt2)
    @test isapprox(sqrt(3), sqrt3)
    @test isapprox(sqrt(pi), sqrtπ)
    @test isapprox(sqrt(2pi), sqrt2π)
    @test isapprox(sqrt(4pi), sqrt4π)
    @test isapprox(sqrt(pi/2), sqrthalfπ)
    @test isapprox(sqrt(1/2), invsqrt2)
    @test isapprox(sqrt(1/(pi)), invsqrtπ)
    @test isapprox(sqrt(1/(2pi)), invsqrt2π)
end

@testset "log" begin
    @test isapprox(log(1/2), loghalf)
    @test isapprox(log(2), logtwo)
    @test isapprox(log(10), logten)
    @test isapprox(log(pi), logπ)
    @test isapprox(log(2pi), log2π)
    @test isapprox(log(4pi), log4π)
end

@testset "type system" begin
    @test twoπ === IrrationalConstants.Twoπ()
    @test twoπ isa IrrationalConstants.IrrationalConstant
    @test twoπ isa AbstractIrrational
end

@testset "hash" begin
    for i in (twoπ, invπ, sqrt2, logtwo), j in (twoπ, invπ, sqrt2, logtwo)
        @test isequal(i==j, hash(i)==hash(j))
    end
end

@testset "doctests" begin
    DocMeta.setdocmeta!(
        IrrationalConstants, :DocTestSetup, :(using IrrationalConstants); recursive=true
    )
    doctest(IrrationalConstants; manual=false)
end

# copied from https://github.com/JuliaLang/julia/blob/cf5ae0369ceae078cf6a29d7aa34f48a5a53531e/test/numbers.jl
# and adapted to irrationals in this package

@testset "IrrationalConstant zero and one" begin
    @test one(twoπ) === true
    @test zero(twoπ) === false
    @test one(typeof(twoπ)) === true
    @test zero(typeof(twoπ)) === false
end

@testset "IrrationalConstants compared with IrrationalConstants" begin
    for i in (twoπ, invπ, sqrt2, logtwo), j in (twoπ, invπ, sqrt2, logtwo)
        @test isequal(i==j, Float64(i)==Float64(j))
        @test isequal(i!=j, Float64(i)!=Float64(j))
        @test isequal(i<=j, Float64(i)<=Float64(j))
        @test isequal(i>=j, Float64(i)>=Float64(j))
        @test isequal(i<j, Float64(i)<Float64(j))
        @test isequal(i>j, Float64(i)>Float64(j))
    end
end

@testset "IrrationalConstant Inverses, JuliaLang/Julia Issue #30882" begin
    @test @inferred(inv(twoπ)) ≈ 0.15915494309189535
end

@testset "IrrationalConstants compared with Rationals and Floats" begin
    @test Float64(twoπ, RoundDown) < twoπ
    @test Float64(twoπ, RoundUp) > twoπ
    @test !(Float64(twoπ, RoundDown) > twoπ)
    @test !(Float64(twoπ, RoundUp) < twoπ)
    @test Float64(twoπ, RoundDown) <= twoπ
    @test Float64(twoπ, RoundUp) >= twoπ
    @test Float64(twoπ, RoundDown) != twoπ
    @test Float64(twoπ, RoundUp) != twoπ

    @test Float32(twoπ, RoundDown) < twoπ
    @test Float32(twoπ, RoundUp) > twoπ
    @test !(Float32(twoπ, RoundDown) > twoπ)
    @test !(Float32(twoπ, RoundUp) < twoπ)

    @test prevfloat(big(twoπ)) < twoπ
    @test nextfloat(big(twoπ)) > twoπ
    @test !(prevfloat(big(twoπ)) > twoπ)
    @test !(nextfloat(big(twoπ)) < twoπ)

    @test 5293386250278608690//842468587426513207 < twoπ
    @test !(5293386250278608690//842468587426513207 > twoπ)
    @test 5293386250278608690//842468587426513207 != twoπ
end
IrrationalConstants.@irrational i46051 4863.185427757 1548big(pi)
@testset "IrrationalConstant printing" begin
    @test sprint(show, "text/plain", twoπ) == "twoπ = 6.2831853071795..."
    @test sprint(show, "text/plain", twoπ, context=:compact => true) == "twoπ"
    @test sprint(show, twoπ) == "twoπ"
    # JuliaLang/Julia issue #46051
    @test sprint(show, "text/plain", i46051) == "i46051 = 4863.185427757..."
end

@testset "IrrationalConstant/Bool multiplication" begin
    @test false*twoπ === 0.0
    @test twoπ*false === 0.0
    @test true*twoπ === Float64(twoπ)
    @test twoπ*true === Float64(twoπ)
end

# JuliaLang/Julia issue #26324
@testset "irrational promotion" begin
    @test twoπ*ComplexF32(2) isa ComplexF32
    @test twoπ/ComplexF32(2) isa ComplexF32
    @test log(twoπ, ComplexF32(2)) isa ComplexF32
end

# issue #23
@testset "rounding irrationals" begin
    # without rounding mode
    @test @inferred(round(twoπ)) == 6.0
    @test @inferred(round(sqrt2)) == 1.0
    @test @inferred(round(sqrt3)) == 2.0
    @test @inferred(round(loghalf)) == -1.0

    # with rounding modes
    for mode in (RoundDown, RoundToZero, RoundNearest, RoundNearestTiesAway, RoundNearestTiesUp)
        @test @inferred(round(twoπ, mode)) == 6.0
        @test @inferred(round(sqrt2, mode)) == 1.0
    end
    @test @inferred(round(sqrt3, RoundUp)) == 2.0
    for mode in (RoundUp, RoundToZero)
        @test @inferred(round(loghalf, mode)) == 0.0
    end
end

@testset "trigonometric functions" begin
    # 2π, 4π
    for (n, x) in ((2, twoπ), (4, fourπ))
        @test sin(x) === sinpi(n) === sin(0.0)
        @test cos(x) === cospi(n) === cos(0.0)
    end

    # halfπ, quartπ
    for (r, x) in ((big"0.5", halfπ), (big"0.25", quartπ))
        @test sin(x) === Float64(sinpi(r))
        @test cos(x) === Float64(cospi(r))
    end

    # Check consistency of definitions
    for x in (twoπ, fourπ, halfπ, quartπ)
        @test sincos(x) === (sin(x), cos(x))
        @test tan(x) === sin(x) / cos(x)
    end

    # Check `csc`, `sec`, and `cot`
    for x in (twoπ, fourπ, halfπ)
        # These are defined automatically via sin, cos, and tan
        @test csc(x) === 1 / sin(x)
        @test sec(x) === 1 / cos(x)
        @test cot(x) === csc(x) / sec(x)
    end
    @test csc(quartπ) === Float64(csc(big(quartπ)))
    @test sec(quartπ) === Float64(sec(big(quartπ)))
    @test cot(quartπ) === Float64(cot(big(quartπ)))
end
