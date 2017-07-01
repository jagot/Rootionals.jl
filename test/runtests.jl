using Rootionals
using Base.Test

R = Rootional

@test string(R([2], [1//2])) == "√2"
@test string(R([1], [1], [2], [1//2])) == "1/√2"
@test string(R([3], [3//4], [2,6], [2,1//3])) == "(∜3)³/2²∛6"

@test num(R([1], [1], [2], [1//2])) == one(R)
@test den(R([1], [1], [2], [1//2])) == R([2], [1//2])

@test zero(R) == R([0], [1])
