ENV["GENIE_ENV"] = "dev"
push!(LOAD_PATH, "app/resources/insurancecontracts")
using Pkg
Pkg.add("Revise")
using Revise
include("test/tests.jl")
