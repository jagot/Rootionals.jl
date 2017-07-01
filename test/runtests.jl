using Rootionals
using Base.Test

R = Rootional

# Construction
@test R(1) == R([1], [1])
@test R(0) == R([0], [1])

@test R(3//5) == R([3, 5], [1, -1])

@test one(R) == R(1)
@test zero(R) == R(0)

# Access
@test num(R([2], [1//2])) == R([2], [1//2])
@test num(R([2], [-1//2])) == one(R)
@test den(R([2], [1//2])) == one(R)
@test den(R([2], [-1//2])) == R([2], [1//2])

# Simplification
@test simplify!(R([3,3], [4, -1//2])) == R([3], [7//2])
@test simplify!(R([2], [0])) == one(R)
@test simplify!(R([7], [-0//2])) == one(R)

# Conversions
@test one(R) == 1
@test 5 == R(5)
@test R(3//5) == 3//5
@test 7//7 == one(R)

# Arithmetic
## Multiplication
@test R(2)*R(1//3) == R(2//3)
@test R(2)*R(1//2) == one(R)
@test R(2)*R([2], [1//2]) == R([2], [3//2])
@test R(2)*R([2], [-1//2]) == R([2], [1//2])
@test 2R([2], [-1//2]) == R([2], [1//2])
@test R([2], [-1//2])*1//2 == R([2], [-3//2])

## Division
@test R(2)/R(2) == one(R)
@test R([2], [1//2])/2 == R([2], [-1//2])
@test 2/R([4, 5], [1, 1//2]) == R([2, 5], [-1, -1//2])
@test 2/R(16) == R([2], [-3])

## Exponentiation
@test R([2], [1//2])^2 == 2
@test (2R([2], [1//2]))^2 == 8
@test R(4//3)^(1//2) == R([2, 3], [1, -1//2])

## Roots
@test sqrt(R([2], [1//2])) == R([2], [1//4])
@test cbrt(R([2], [1//2])) == R([2], [1//6])

# String representation
@test string(R([2], [1//2])) == "√2"
@test string(R([2], [-1//2])) == "1/√2"
@test string(R([3, 2, 6], [3//4, -2, -1//3])) == "(∜3)³/2²∛6"
@test string(R([5], [17//8])) == "(⁸√5)¹⁷"

