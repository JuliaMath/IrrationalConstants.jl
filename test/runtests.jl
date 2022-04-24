using IrrationalConstants
using Test

const IRRATIONALS = (
    twoπ,
    fourπ,
    halfπ,
    quartπ,
    invπ,
    twoinvπ,
    fourinvπ,
    inv2π,
    inv4π,
    sqrt2,
    sqrt3,
    sqrtπ,
    sqrt2π,
    sqrt4π,
    sqrthalfπ,
    invsqrt2,
    invsqrtπ,
    invsqrt2π,
    loghalf,
    logtwo,
    logten,
    logπ,
    log2π,
    log4π,
)

function test_with_function(f, a::Irrational)
    b = f(a)
    @test b ≈ f(float(a)) atol=1e-14

    # If f(a) is approximately equal to a value in IRRATIONALS, f(a) should be Irrational.
    @test (b .≈ IRRATIONALS) == (b .=== IRRATIONALS)

    # If f(a) is close to integer, it should be a integer.
    if abs(b - round(b)) < 1e-14
        @test isinteger(b)
    end
end

@testset "approximately equal" begin
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
end

@testset "rules for $(a)" for a in IRRATIONALS
    @testset "log" begin
        if a > 0
            test_with_function(log, a)
        end
    end

    @testset "inv" begin
        test_with_function(inv, a)
    end

    @testset "exp" begin
        test_with_function(exp, a)
    end

    @testset "sin" begin
        test_with_function(sin, a)
        test_with_function(cos, a)
        @test sincos(a) == (sin(a),cos(a))
    end

    @testset "square" begin
        test_with_function(t->t*t, a)
    end
end
