using gps
using Test

const pi = gps.pi
const π = gps.pi
# lamp post b12
@testset "gps.jl" begin
    include("prelude.jl")
    include("satellites.jl")
    include("newton.jl")
end
