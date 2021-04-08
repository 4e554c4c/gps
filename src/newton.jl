module Newton
using ForwardDiff
export newton

"""
    newton(f, x; ∇f=f', δ=eps(f(x)))
Find a root of `f` with derivative `∇f` within accuracy of `δ` and start point `x`.

By default `δ` is the machine epsilon of the output type at `1` of `f` and `∇f` is the
automatic differentiation of `f`. These assume that `f` is a real-valued function.
"""
function newton(f::Function, x::Real; ∇f::Function=x->ForwardDiff.derivative(f,x), δ=eps(typeof(f(x))))::Real
    while true
        last = x
        x = x-f(x)/∇f(x)
        (abs(x-last)≥δ) || break
    end
    x
end

end
