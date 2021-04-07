using gps
using LinearAlgebra
using LeastSquares
#using gps.Satellite
const π=gps.π
const pi=gps.π

xvguess = b12
#==
 = We deliminate epochs in the following method:
 = as long as long as our satellite input is increasing we assume that we are
 = reading input for the same location. The moment it decreases or the input
 = ends, we perform our computation.
 = This is possibly incorrect behaviour if, say, epoch 0 has sats 1,2,3 and
 = epoch 1 has 4,5,6. But we assume that satellite changes occur continuously
 = enough that this cannot be the case.
 =#
lastsat = 0

function parseline(line::String)::Tuple{Integer, Real, Coordinates, String}
    spl = split(line)
    parse(Int, spl[1]), BigFloat(spl[2]), BigFloat.(spl[3:end]), line
end

lines = map(parseline, readlines())
i=1

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
    F(x)=[norm(sn[3]-x)-norm(s[3]-x)-c*(s[2]-sn[2]) for (s,sn) in zip(sats, sats[begin+1:end])]

    # Now get some minimum from least squares. We only need .01m accuracy.
    x = leastsquares(F, xvguess; δ=.01)

    # We also need the time, but this is easy to get from our system.
    # Assuming we have at least one satellite...
    t = (norm(x-sats[1][3])+sats[1][2])/c

    # Now go back from Cartesian to dms+h coordinates
    ψ, λ, h = cart2ll(x, t=t)
    
    #splitline = split(line)
    #t=parse(BigFloat, splitline[1])
    #ψ=parsedms(splitline[2:5])
    #λ=parsedms(splitline[6:9])
    #h=parse(BigFloat, splitline[10])
    ##println(line, " → ", (t,ψ,λ,h))
    #ℓ = ll2cart(ψ,λ,h,t)
    #for (is, sat) in enumerate(Satellite.satellites)
    #    xs, ts = satloc(sat, ℓ, t)
    #    if abovehorizon(ℓ, xs)
    #        println(is-1, ' ', ts, ' ', xs[1], ' ', xs[2], ' ', xs[3]) 
    #    end
    #end
    # now we want a new location guess with our current location.
    global xvguess = x
    global lastsat=0
    global i=j+1
end
