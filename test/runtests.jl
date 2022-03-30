using BitempWebApp, Test
# implement your tests here
push!(LOAD_PATH,"app/resources/insurancecontracts")
include("testsCreateContract.jl")
include("testsUpdateYellow.jl")
include("testsUpdateRed.jl")
