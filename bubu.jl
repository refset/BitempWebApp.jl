### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ f4eb2368-a521-46cc-9b2e-1c246361b14c
begin
using Pkg
	Pkg.add("SearchLight")
	Pkg.add("SearchLightPostgreSQL")
	Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
	Pkg.add("Intervals")
	Pkg.add("TimeZones")
	using Intervals
	using TimeZones
	using SearchLight
	using SearchLightPostgreSQL
	using BitemporalPostgres
	using InsurancePartnersController
	using InsuranceContractsController
	SearchLight.Configuration.load() |> SearchLight.connect
	p=Partner()
	pr=PartnerRevision(description="blue")
	println(pr)
	w=Workflow()
	create_entity!(w)
	create_component!(p,pr,w)
end

# ╔═╡ a6c71f5c-da06-4c4b-9218-a05ff5ed41f4
begin
	ENV["GENIE_ENV"]="dev"
	push!(LOAD_PATH,"app/resources/insurancecontracts")
	push!(LOAD_PATH,"app/resources/insurancepartners")
end

# ╔═╡ e2618464-4b98-414b-9ca6-7ed2964bcdc1
LOAD_PATH

# ╔═╡ f1d1e5a8-971e-11ec-3e3d-d5ff8e7e9ada
cd("/workspace/BitempWebApp.jl")

# ╔═╡ Cell order:
# ╠═f1d1e5a8-971e-11ec-3e3d-d5ff8e7e9ada
# ╠═a6c71f5c-da06-4c4b-9218-a05ff5ed41f4
# ╠═e2618464-4b98-414b-9ca6-7ed2964bcdc1
# ╠═f4eb2368-a521-46cc-9b2e-1c246361b14c
