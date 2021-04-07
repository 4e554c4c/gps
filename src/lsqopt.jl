module LeastSquares
import Optim

export leastsquares

function leastsquares(F::Function,  x0::T; J=nothing, δ=nothing)::Tm
    kwargs = Dict()
    if J ≢ nothing
        #TODO push!(kwargs, :
    end
    if δ ≢ nothing
        push!(kwargs, :x_tol => δ)
    end
    # Now lets create a function that represents the least squares of `F` which
    # we want to minimize
    f(x) = F(x)⋅F(x)
    Optim.optimize(f, x0, kwargs...; autodiff = :forward)
end
