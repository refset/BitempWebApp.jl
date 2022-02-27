push!(LOAD_PATH,"./src")
push!(LOAD_PATH,"./app/resources/insurancecontracts")
push!(LOAD_PATH,"./app/resources/insurancepartners")
using Documenter
using BitempWebApp
using InsuranceContractsController
using InsurancePartnersController

makedocs(
    sitename = "BitempWebApp",
    format = Documenter.HTML(),
    modules = [BitempWebApp,InsuranceContractsController,InsurancePartnersController]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "https://github.com/Kaeptenblaubaer/BitempWebApp.jl"
)
