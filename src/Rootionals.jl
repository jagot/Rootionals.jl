module Rootionals
using UnicodeFun
using Primes

import Base: num, den, one, zero, show, ==,
    *, /, ^, sqrt, cbrt

type Rootional
    b::Vector{Int}
    e::Vector{Rational}
end

Rootional(z::Int) = simplify!(Rootional([z], [1]))
Rootional(q::Rational) = simplify!(Rootional([num(q), den(q)], [1, -1]))

one(::Type{Rootional}) = Rootional(1)
zero(::Type{Rootional}) = Rootional(0)

==(a::Rootional, b::Rootional) = (a.b == b.b) && (a.e == b.e)
==(a::Rootional, b::Union{Int,Rational}) = a == Rootional(b)
==(a::Union{Int,Rational}, b::Rootional) = Rootional(a) == b

*(a::Rootional, b::Rootional) =
    simplify!(Rootional(vcat(a.b,b.b), vcat(a.e, b.e)))
*(a::Rootional, b::Union{Int,Rational}) = a*Rootional(b)
*(a::Union{Int,Rational}, b::Rootional) = Rootional(a)*b

/(a::Rootional, b::Rootional) =
    simplify!(Rootional(vcat(a.b,b.b), vcat(a.e, -b.e)))
/(a::Rootional, b::Union{Int,Rational}) = a/Rootional(b)
/(a::Union{Int,Rational}, b::Rootional) = Rootional(a)/b

^(a::Rootional, e::Union{Int,Rational}) = simplify!(Rootional(a.b, e*a.e))

sqrt(a::Rootional) = a^(1//2)
cbrt(a::Rootional) = a^(1//3)

function format_factor(n,e)
    en = num(e)
    ed = den(e)
    core = if ed == 1
        "$(n)"
    else
        root = if ed == 2
            "√"
        elseif ed == 3
            "∛"
        elseif ed == 4
            "∜"
        else
            "$(to_superscript(ed))√"
        end
        "$(root)$(n)"
    end
    if en == 1
        core
    else
        es = to_superscript(en)
        if ed == 1
            "$(core)$(es)"
        else
            "($(core))$(es)"
        end
    end
end

function show(stream::IO, r::Rootional)
    ni = find(r.e .> 0)
    di = find(r.e .< 0)
    if length(ni) > 0
        for i in ni
            write(stream, format_factor(r.b[i],r.e[i]))
        end
    else
        write(stream, "1")
    end
    if length(di) > 0
        write(stream, "/")
        for i in di
            write(stream, format_factor(r.b[i],-r.e[i]))
        end
    end
end

function num(r::Rootional)
    ni = find(r.e .> 0)
    if length(ni) > 0
        Rootional(r.b[ni], r.e[ni])
    else
        one(Rootional)
    end
end

function den(r::Rootional)
    di = find(r.e .< 0)
    if length(di) > 0
        Rootional(r.b[di], -r.e[di])
    else
        one(Rootional)
    end
end

"Simplify a rootional by cancelling and merging common bases."
function simplify!(r::Rootional)
    d = Dict{Int,Rational}()
    for i in eachindex(r.b)
        for (f,e) in factor(r.b[i])
            d[f] = get(d, f, 0) + e*r.e[i]
        end
    end
    delete!(d, 1)
    for b in keys(d)
        d[b] == 0 && delete!(d, b)
    end
    length(d) == 0 && (d[1]=1)
    r.b = sort(collect(keys(d)))
    r.e = [d[b] for b in r.b]
    r
end


export Rootional, simplify!

end # module
