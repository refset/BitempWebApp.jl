ENV["GENIE_ENV"] = "dev"
push!(LOAD_PATH, "app/resources/insurancecontracts")
using Pkg
Pkg.add("Revise")
using Revise
run(```psql -f sqlsnippets/droptables.sql```)
include("test/tests.jl")
