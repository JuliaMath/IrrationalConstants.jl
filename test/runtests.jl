using IrrationalConstants
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

