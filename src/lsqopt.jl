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
function leastsquares(F::Function, x₀::Vector{<:Real};
        δ::Real=0.0)::Vector{<:Real}
    Optim.optimize(x->F(x)⋅F(x), x₀, method=Optim.LBFGS(),
                   x_tol=δ, autodiff = :forward) |> Optim.minimizer
end
end
