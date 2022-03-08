push!(LOAD_PATH,"./src")
push!(LOAD_PATH,"./app/resources/insurancecontracts")
using Documenter
using Pkg
Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
import BitempWebApp
using InsuranceContracts, InsurancePartners

makedocs(
    sitename = "BitempWebApp",
    format = Documenter.HTML(),
    modules = [BitempWebApp,InsuranceContracts, InsurancePartners],
    pages = [
        "Home" => "index.md",
        "BitempWebApp API" => [
            "BitempWebApp" => "api/BitempWebApp.md",
            "InsuranceContractsController" => "api/InsuranceContractsController.md"
        ]
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/michaelfliegner/BitempWebApp.jl"
)
