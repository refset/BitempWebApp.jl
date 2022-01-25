push!(LOAD_PATH,"src")
import Pkg
Pkg.add("Genie")
using Genie, BitempWebApp, Test
# implement your tests here
@test 1 == 1
print("tested")
