module Parse
export latlong
import gps

parsedms(dms::Vector{<:AbstractString})::BigFloat =
    gps.dms2rad(parse.(Int,dms[1:2])...,parse(BigFloat,dms[3]), parse(Int, dms[4]))

"""
    latlong(dat)
Parses one line of the form

``t_v\\quad ψ_d\\quad ψ_s\\quad \\mathbf{NS}\\quad λ_d\\quad λ_s\\quad \\mathbf{EW}\\quad h``

into latitude, longitude (in radians), height and time.
"""
function latlong(line::AbstractString)::Tuple{BigFloat, BigFloat, BigFloat, BigFloat}
    splitline = split(line)
    t=parse(BigFloat, splitline[1])
    ψ=parsedms(splitline[2:5])
    λ=parsedms(splitline[6:9])
    h=parse(BigFloat, splitline[10])
    ψ,λ,h,t
end

"""
    satline(line)
Parses one line of the form ``i_s\\quad t_s\\quad \\mathbf{x}_s`` into a sat number,
local time and coordinates.
"""
function satline(line::AbstractString)::Tuple{Integer, Real, gps.Coordinates}
    spl = split(line)
    parse(Int, spl[1]), BigFloat(spl[2]), BigFloat.(spl[3:end])
end

end
