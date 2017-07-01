using Rootionals
using Base.Test

@test string(Rootional([2], [1//2])) == "√2"
@test string(Rootional([1], [1], [2], [1//2])) == "1/√2"
@test string(Rootional([3], [3//4], [2,6], [1,1//3])) == "(∜3)³/2∛6"

@test num(Rootional([1], [1], [2], [1//2])) == one(Rootional)
@test den(Rootional([1], [1], [2], [1//2])) == Rootional([2], [1//2])
