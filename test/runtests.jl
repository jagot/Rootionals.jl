using Rootionals
using Base.Test

R = Rootional

@test R(1) == R([1], [1])
@test R(0) == R([0], [1])

@test R(3//5) == R([3, 5], [1, -1])

@test one(R) == R(1)
@test zero(R) == R(0)

@test one(R) == 1
@test 5 == R(5)
@test R(3//5) == 3//5
@test simplify!(R([3,3], [4, -1//2])) == R([3], [7//2])
@test 7//7 == one(R)

@test string(R([2], [1//2])) == "√2"
@test string(R([2], [-1//2])) == "1/√2"
@test string(R([3, 2, 6], [3//4, -2, -1//3])) == "(∜3)³/2²∛6"
@test string(R([5], [17//8])) == "(⁸√5)¹⁷"

@test num(R([2], [1//2])) == R([2], [1//2])
@test num(R([2], [-1//2])) == one(R)
@test den(R([2], [1//2])) == one(R)
@test den(R([2], [-1//2])) == R([2], [1//2])
