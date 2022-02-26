push!(LOAD_PATH,"./src")
using Pkg
Pkg.update()
Pkg.add("Revise")
Pkg.add("SearchLight")
Pkg.add("SearchLightPostgreSQL")
Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
Pkg.add("Intervals")
Pkg.add("TimeZones")
Pkg.add("Dates")
using Revise
using SearchLight
using SearchLightPostgreSQL
using BitemporalPostgres
using TimeZones

SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
BitemporalPostgres.up()
SearchLight.Migrations.up()
