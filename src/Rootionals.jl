module Rootionals
using UnicodeFun

import Base: num, den, one, zero, show, ==

type Rootional
    num::Vector{Int}
    num_exp::Vector{Rational}
    den::Vector{Int}
    den_exp::Vector{Rational}
end
Rootional(num, num_exp) = Rootional(num, num_exp, [1], [1])
one(::Type{Rootional}) = Rootional([1], [1])
zero(::Type{Rootional}) = Rootional([0], [1])

==(a::Rootional, b::Rootional) =
    (a.num == b.num) && (a.num_exp == b.num_exp) &&
    (a.den == b.den) && (a.den_exp == b.den_exp)

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
            "√$(to_superscript(ed))"
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
    for i in eachindex(r.num)
        write(stream, format_factor(r.num[i],r.num_exp[i]))
    end
    if r.den != [1]
        write(stream, "/")
        for i in eachindex(r.den)
            write(stream, format_factor(r.den[i],r.den_exp[i]))
        end
    end
end

num(r::Rootional) = Rootional(r.num, r.num_exp, [1], [1])
den(r::Rootional) = Rootional(r.den, r.den_exp, [1], [1])


export Rootional

end # module
