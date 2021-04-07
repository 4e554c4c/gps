using gps
using LinearAlgebra
ACCURACY=.01 # 1cm
#println(ARGS)

if length(ARGS) ≠ 2
    println("Usage: <prgm> ref.log test.log")
    exit(-1)
end

function parseline(line::String)::Tuple{Integer, Real, Coordinates, String}
    spl = split(line)
    parse(Int, spl[1]), BigFloat(spl[2]), BigFloat.(spl[3:end]), line
end

ref = map(parseline, readlines(ARGS[1]))
tst = map(parseline, readlines(ARGS[2]))

for (lnum, (l1, l2)) in enumerate(zip(ref,tst))
    println("testing line ", lnum, ":", l1[4])
    if l1[1] ≠ l2[1]
        print_with_color(:red, "Error on line ", lnum, " satellite number differs\n")
        println("Reference line: ", l1[4])
        println("Test line     : ", l1[4])
        exit(-1)
    end
    δ=norm(l1[3]-l2[3])
    μ=maximum(abs.(l1[3]-l2[3]))
    println("δ=",δ,",μ=",μ)
    if δ≥ACCURACY || μ≥ACCURACY
        print_with_color(:red, "Error on line ", lnum, ",coordinates differ by ",δ, " meters which is greater than tolerance ", ACCURACY, "\n")
        println("Reference line: ", l1[4])
        println("Test line     : ", l1[4])
        exit(-1)
    end
end
