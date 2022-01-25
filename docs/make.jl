using Documenter
using BitempWebApp

makedocs(
    sitename = "BitempWebApp",
    format = Documenter.HTML(),
    modules = [BitempWebApp]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "repo = "https://github.com/Kaeptenblaubaer/BitempWebApp.jl""
)
