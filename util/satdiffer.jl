using gps
import gps.Parse
using LinearAlgebra
ACCURACY=.01 # 1cm
#println(ARGS)

if length(ARGS) ≠ 2
    println("Usage: <prgm> ref.log test.log")
    exit(-1)
end

ref = map(ℓ->(Parse.satline(ℓ), ℓ), readlines(ARGS[1]))
tst = map(ℓ->(Parse.satline(ℓ), ℓ), readlines(ARGS[2]))

for (lnum, ((l1, l1v), (l2, l2v))) in enumerate(zip(ref,tst))
    println("testing line ", lnum, ":", l1v)
    if l1[1] ≠ l2[1]
        printstyled("Error on line $lnum satellite number differs\n"; color=:red)
        println("Reference line: ", l1v)
        println("Test line     : ", l2v)
        exit(-1)
    end
    δ=norm(l1[3]-l2[3])
    println("δ=",δ)
    if δ≥ACCURACY
        printstyled("Error on line $lnum coordinates differ by $δ meters which is greater than tolerance $ACCURACY\n"; color=:red)
        println("Reference line: ", l1v)
        println("Test line     : ", l2v)
        exit(-1)
    end
end
