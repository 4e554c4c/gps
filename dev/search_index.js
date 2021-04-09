var documenterSearchIndex = {"docs":
[{"location":"parse/#Parser","page":"Parser","title":"Parser","text":"","category":"section"},{"location":"parse/","page":"Parser","title":"Parser","text":"Parser utility functions","category":"page"},{"location":"parse/","page":"Parser","title":"Parser","text":"Modules = [gps.Parse]\nOrder   = [:type, :function]","category":"page"},{"location":"parse/#gps.Parse.latlong-Tuple{AbstractString}","page":"Parser","title":"gps.Parse.latlong","text":"latlong(dat)\n\nParses one line of the form\n\nt_vquad ψ_dquad ψ_squad mathbfNSquad λ_dquad λ_squad mathbfEWquad h\n\ninto latitude, longitude (in radians), height and time.\n\n\n\n\n\n","category":"method"},{"location":"parse/#gps.Parse.satline-Tuple{AbstractString}","page":"Parser","title":"gps.Parse.satline","text":"satline(line)\n\nParses one line of the form i_squad t_squad mathbfx_s into a sat number, local time and coordinates.\n\n\n\n\n\n","category":"method"},{"location":"prelude/#Prelude","page":"Prelude","title":"Prelude","text":"","category":"section"},{"location":"prelude/","page":"Prelude","title":"Prelude","text":"Functions visible to the entire gps project","category":"page"},{"location":"prelude/","page":"Prelude","title":"Prelude","text":"Modules = [gps]\nPages   = [\"prelude.jl\"]","category":"page"},{"location":"prelude/#gps.cart2ll","page":"Prelude","title":"gps.cart2ll","text":"cart2ll(coords, t=0)\n\nConvert Cartesian coordinates into latitude, longitude and height\n\nThe inverse of ll2cart\n\n\n\n\n\n","category":"function"},{"location":"prelude/#gps.dms2rad","page":"Prelude","title":"gps.dms2rad","text":"dms2rad(d, m=0, s=0, σ=1)\n\nGiven degrees, minutes, seconds and sign of an angle convert to a radian value.\n\nThe inverse of rad2dms.\n\n\n\n\n\n","category":"function"},{"location":"prelude/#gps.ll2cart","page":"Prelude","title":"gps.ll2cart","text":"ll2cart(ψ, λ, h, t=0)\n\nConvert latitude, longitude, height and time to (x,y,z) coordinates\n\n\n\n\n\n","category":"function"},{"location":"prelude/#gps.rad2dms-Tuple{Real}","page":"Prelude","title":"gps.rad2dms","text":"rad2dms(α)\n\nGiven a radian value convert to degrees, minutes and seconds.\n\nThe inverse of dms2rad.\n\n\n\n\n\n","category":"method"},{"location":"prelude/#gps.rot_z-Tuple{Real}","page":"Prelude","title":"gps.rot_z","text":"rot_z(α)\n\nGenerates a 3d \"roll\" rotation matrix about the z axis by α radians\n\n\n\n\n\n","category":"method"},{"location":"prelude/#gps.validatecoords-Tuple{Vararg{Array{#s13,1} where #s13<:Real,N} where N}","page":"Prelude","title":"gps.validatecoords","text":"validatecoords(x...)\n\nValidate all coordinates as being elements of ℝ^3\n\n\n\n\n\n","category":"method"},{"location":"satellite/#Satellite","page":"Satellite","title":"Satellite","text":"","category":"section"},{"location":"satellite/","page":"Satellite","title":"Satellite","text":"Utility functions for working with satellites and satellite definitions.","category":"page"},{"location":"satellite/","page":"Satellite","title":"Satellite","text":"Modules = [gps.Satellite]\nOrder   = [:type, :function]","category":"page"},{"location":"satellite/#gps.Satellite.Sat","page":"Satellite","title":"gps.Satellite.Sat","text":"Sat(u,v,p,a,θ)\n\nA satellite with an orbit of periodicity p, altitude a, phase θ such that at time zero the position of the satellite is mathbfucos(θ)+mathbfvsin(θ)\n\n\n\n\n\n","category":"type"},{"location":"satellite/#gps.Satellite.position-Tuple{gps.Satellite.Sat,Real}","page":"Satellite","title":"gps.Satellite.position","text":"positions(s, t)\n\nReturns the position of the satellite s at time t.\n\n\n\n\n\n","category":"method"},{"location":"opt/#Optimization-Utilities","page":"Optimization Utilities","title":"Optimization Utilities","text":"","category":"section"},{"location":"opt/#Newton","page":"Optimization Utilities","title":"Newton","text":"","category":"section"},{"location":"opt/","page":"Optimization Utilities","title":"Optimization Utilities","text":"Utility functions for working with Newton's method.","category":"page"},{"location":"opt/","page":"Optimization Utilities","title":"Optimization Utilities","text":"Modules = [gps.Newton]\nOrder   = [:type, :function]","category":"page"},{"location":"opt/#gps.Newton.newton-Tuple{Function,Real}","page":"Optimization Utilities","title":"gps.Newton.newton","text":"newton(f, x; ∇f=f', δ=eps(f(x)))\n\nFind a root of f with derivative ∇f within accuracy of δ and start point x.\n\nBy default δ is the machine epsilon of the output type at 1 of f and ∇f is the automatic differentiation of f. These assume that f is a real-valued function.\n\n\n\n\n\n","category":"method"},{"location":"opt/#Least-Squares","page":"Optimization Utilities","title":"Least Squares","text":"","category":"section"},{"location":"opt/","page":"Optimization Utilities","title":"Optimization Utilities","text":"A method to compute the least-squares optimization problem","category":"page"},{"location":"opt/","page":"Optimization Utilities","title":"Optimization Utilities","text":"Modules = [gps.LeastSquares]\nOrder   = [:type, :function]","category":"page"},{"location":"opt/#gps.LeastSquares.leastsquares-Tuple{Function,Array{#s20,1} where #s20<:Real}","page":"Optimization Utilities","title":"gps.LeastSquares.leastsquares","text":"leastsquares(F, x₀; [δ])\n\nMinimize F as much as possible within accuracy of δ and start point x₀.\n\nF must be a vector-valued function of a vector-valued input. If F is a vector-valued function with a scalar input, call leastsquares(x->F(x[1]), [x₀]) instead.\n\nThis also assumes that F is written 100% in Julia and accepts any Real input. If this is not so, the automatic differentiation may not succeed.\n\n\n\n\n\n","category":"method"},{"location":"#gps.jl","page":"gps.jl","title":"gps.jl","text":"","category":"section"},{"location":"","page":"gps.jl","title":"gps.jl","text":"Documentation for gps.jl","category":"page"},{"location":"","page":"gps.jl","title":"gps.jl","text":"","category":"page"}]
}
