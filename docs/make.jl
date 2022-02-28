push!(LOAD_PATH,"./src")
push!(LOAD_PATH,"./app/resources/insurancecontracts")
push!(LOAD_PATH,"./app/resources/insurancepartners")
using Documenter
using Pkg
Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
import BitempWebApp
using InsuranceContractsController
using InsurancePartnersController

makedocs(
    sitename = "BitempWebApp",
    format = Documenter.HTML(),
    modules = [BitempWebApp,InsuranceContractsController,InsurancePartnersController],
    pages = [
        "Home" => "index.md",
        "BitempWebApp API" => [
            "BitempWebApp" => "api/BitempWebApp.md",
            "InsuranceContractsController" => "api/InsuranceContractsController.md",
            "InsurancePartnersController" => "api/InsurancePartnersController.md"
        ]
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/michaelfliegner/BitempWebApp.jl"
)
