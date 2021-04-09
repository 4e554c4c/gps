using gps
using LinearAlgebra
using gps.LeastSquares
import gps.Parse
#using gps.Satellite
const π=gps.π
const pi=gps.π

xvguess = ll2cart(b12...)
#==
 = We deliminate epochs in the following method:
 = as long as long as our satellite input is increasing we assume that we are
 = reading input for the same location. The moment it decreases or the input
 = ends, we perform our computation.
 = This is possibly incorrect behaviour if, say, epoch 0 has sats 1,2,3 and
 = epoch 1 has 4,5,6. But we assume that satellite changes occur continuously
 = enough that this cannot be the case.
 =#
lastsat = -1

lines = map(Parse.satline, readlines())
i=1

function dmsfmt(α::Real)::String
    d, m, s, σ = rad2dms(α)
    "$d $m $s $σ"
end

while i≤length(lines)
    # find the end of the epoch
    j=i
    while j<length(lines)
        if lines[j][1] ≤ lastsat
            j-=1;
            break;
        end
        global lastsat=lines[j][1]
        j += 1
    end
    #println("epoch: ", i,':',j, ", satellites: ", map(x->x[1], lines[i:j]))
    # Ok now that that's over with
    sats = lines[i:j]
    # We need to define some function to minimize with least squares. The case
    # with ≤4 satellites can be considered a degenerate form of this.
    # In particular our F is 3x(j-i-1) dimensional with 
    #function Fopt(x::Coordinates)::Coordinates
    #    [norm(sn[3]-x)-norm(s[3]-x)-c*(s[2]-sn[2])
    #     for (s,sn) in zip(sats, sats[begin+1:end])]
    #end
    #we can also solve with time as an unknown, 
    function Fopt(is::Vector{<:Real})::Coordinates
        t, x =is[begin], is[begin+1:end]
        [norm(x-s[3])-c*(t-s[2]) for s in sats]
    end

    # Now get some minimum from least squares. We only need .01m accuracy.
    # but we need t in .01/c accuracy. Thus we need to solve the entire system
    # to that accuracy.
    min = leastsquares(Fopt, [sats[1][2], xvguess...]; δ=.001/c)
    t, x = min[begin], min[begin+1:end]

    # We also need the time, but this is easy to get from our system.
    # since t = (norm(x-sats[1][3])+sats[1][2])/c. However, this isn't accurate
    # enough, since we need an error in `t`

    # Now go back from Cartesian to dms+h coordinates
    ψ, λ, h = cart2ll(x, t)
    println("$t $(dmsfmt(ψ)) $(dmsfmt(λ)) $h")

    global xvguess = x
    global lastsat=-1
    global i=j+1
end
