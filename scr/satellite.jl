using gps
using LinearAlgebra
using gps.Satellite
import gps.Parse
const π=gps.π

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
    _, _, _, t = Parse.latlong(line)
    ℓ = ll2cart(Parse.latlong(line)...)
    for (is, sat) in enumerate(Satellite.satellites)
        xs, ts = satloc(sat, ℓ, t)
        if abovehorizon(ℓ, xs)
            println("$(is-1) $ts $(xs[1]) $(xs[2]) $(xs[3])") 
        end
    end
end
