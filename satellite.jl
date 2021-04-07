using gps
using LinearAlgebra
using gps.Satellite
const π=gps.π
const pi=gps.π
"""
    satloc(sat, ℓ, t)
Find the cartesian coordinates and time of the satellite such that its
broadcast at that location will reach coordinates `ℓ` at time `t`.
"""
function satloc(sat::Sat, xv::Coordinates, tv::Real)::Tuple{Coordinates,<:Real}
    # This function should have a root at the time we desire
    # we use the "square root version" so the sped of light is not squared
    f(t::Real)::Real = norm(Satellite.position(sat,t)-xv)-c*(tv-t)
    # We start our search at the current vehicle time, assuming it will be rather close
    # Furthermore our δ must be less than .01m/c in order to have 1cm accuracy
    t = Newton.newton(f, tv, δ=.01/c)
    Satellite.position(sat, t), t
end

for line in eachline()
    parsedms(dms)::BigFloat = parse(Int,dms[4])*dms2rad(parse.(Int,dms[1:2])...,parse(BigFloat,dms[3]))
    splitline = split(line)
    t=parse(BigFloat, splitline[1])
    ψ=parsedms(splitline[2:5])
    λ=parsedms(splitline[6:9])
    h=parse(BigFloat, splitline[10])
    #println(line, " → ", (t,ψ,λ,h))
    ℓ = ll2cart(ψ,λ,h,t)
    for (is, sat) in enumerate(Satellite.satellites)
        xs, ts = satloc(sat, ℓ, t)
        if abovehorizon(ℓ, xs)
            println(is-1, ' ', ts, ' ', xs[1], ' ', xs[2], ' ', xs[3]) 
        end
    end
end
