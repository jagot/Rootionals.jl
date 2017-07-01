using Rootionals
using Base.Test

R = Rootional

@test R(1) == R([1], [1], [1], [1])
@test R(0) == R([0], [1], [1], [1])

@test R(3//5) == R([3], [1], [5], [1])

@test one(R) == R(1)
@test zero(R) == R(0)

@test string(R([2], [1//2])) == "√2"
@test string(R([1], [1], [2], [1//2])) == "1/√2"
@test string(R([3], [3//4], [2,6], [2,1//3])) == "(∜3)³/2²∛6"

@test num(R([1], [1], [2], [1//2])) == one(R)
@test den(R([1], [1], [2], [1//2])) == R([2], [1//2])
