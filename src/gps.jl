module gps

export Coordinates, validatecoords, dms2rad, rad2dms, ll2cart, cart2ll, abovehorizon, Newton, b12, LeastSquares, Parse

include("data.jl")
include("prelude.jl")
include("satellite.jl")
include("newton.jl")
include("lsqopt.jl")
include("parsing.jl")

const b12 = (dms2rad(40,45,55.0),dms2rad(111,50,58.0,-1), BigFloat(1372.))

end
