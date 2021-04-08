module LeastSquares
using LinearAlgebra
import Optim

export leastsquares


"""
    leastsquares(F, x₀; [δ])
Minimize `F` as much as possible within accuracy of `δ` and start point `x₀`.

`F` must be a vector-valued function of a vector-valued input. If `F` is a
vector-valued function with a scalar input, call `leastsquares(x->F(x[1]), [x₀])` instead.

This also assumes that `F` is written 100% in Julia and accepts any `Real` input.
If this is not so, the automatic differentiation may not succeed.
"""
function leastsquares(F::Function,  x₀::Vector{BigFloat}; δ::Real=nothing)::Vector{BigFloat}
    kwargs = Dict{Symbol,Any}()
    if δ ≢ nothing
        push!(kwargs, :x_tol => δ)
    end
    # Now lets create a function that represents the least squares of `F` which
    # we want to minimize
    #f(x)::Real = F(x)⋅F(x)
    #println("typeof F: $(typeof(F)) typeof x₀: $(typeof(x₀)) typeof f: $(typeof(f))")
    res = Optim.optimize(x->F(x)⋅F(x), x₀, Optim.LBFGS(), Optim.Options(;kwargs...); autodiff = :forward)
    Optim.summary(res)
    Optim.minimizer(res)
end
end
