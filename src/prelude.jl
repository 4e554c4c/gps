using LinearAlgebra

export validatecoords, rad2dms, dms2rad, ll2cart, cart2ll, abovehorizon
Coordinates=Vector{<:Real}
"""
    validatecoords(x...)
Validate all coordinates as being elements of ℝ^3
"""
function validatecoords(coords::Coordinates...)
    for c in coords
        @assert (length(c) ≡ 3) "Coordinates needs to be a length 3 vector"
    end
end

"""
    dms2rad(d, m=0, s=0, σ=1)
Given degrees, minutes, seconds and sign of an angle convert to a radian value.

The inverse of `rad2dms`.
"""
function dms2rad(d::Integer, m::Integer=0, s::Real=0, σ::Integer=1)::Real
    if m >= 60
        error("m > 60");
    elseif s >= 60
        error("s > 60");
    end
    σ*(d + (m + s / 60) / 60)*2π/360
end

"""
    rad2dms(α)
Given a radian value convert to degrees, minutes and seconds.

The inverse of `dms2rad`.
"""
function rad2dms(α::Real)::Tuple{Integer,Integer,Real,Integer}
    σ=1
    if α < 0
        α=-α
        σ=-1
    end
    α = α*360/(2*π)
    d = Int(floor(α))
    m = Int(floor((α-d)*60))
    (d,m,(((α-d)*60-m)*60),σ)
end

# TODO use Givens?
"""
    rot_z(α)
Generates a 3d "roll" rotation matrix about the z axis by `α` radians
"""
rot_z(α::Real)::Matrix{<:Real} = [cos(α) -sin(α) 0; sin(α) cos(α) 0; 0 0 1]

"""
    ll2cart(ψ, λ, h, t=0)
Convert latitude, longitude, height and time to (x,y,z) coordinates
"""
ll2cart(ψ::Real, λ::Real, h::Real, t::Real=0.0)::Coordinates = rot_z(2π*t/s)*[cos(ψ)cos(λ),cos(ψ)sin(λ),sin(ψ)].*(R+h)

"""
    cart2ll(coords, t=0)
Convert Cartesian coordinates into latitude, longitude and height

The inverse of `ll2cart`
"""
function cart2ll(coords::Coordinates, t::Real=0.0)::Tuple{Real,Real,Real}
    validatecoords(coords)
    if t != 0.0
        # undo rotation of earth
        coords = rot_z(-2*π*t/s)*coords
    end
    n = LinearAlgebra.norm(coords)
    (atan(coords[3],LinearAlgebra.norm(coords[1:2])),atan(coords[2],coords[1]),n-R)
end

function abovehorizon(x::Coordinates, s::Coordinates)::Bool
    validatecoords(x,s)
    x⋅(s-x)>0
end

