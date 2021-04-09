export DATA_FILE
const DATA_FILE="data.dat"
open(DATA_FILE) do f
    for (n, l) in  enumerate(eachline(f))
        s = split(l)[1]
        if n > 4
            break;
        end
        sym = [:π,:c,:R,:s][n]
        quote 
            export $sym
            const $sym = BigFloat($s)
        end |> eval
    end
end
