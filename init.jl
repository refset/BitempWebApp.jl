push!(LOAD_PATH,"./src")
using Pkg
Pkg.update()
Pkg.add("Revise")
Pkg.add("SearchLight")
Pkg.add(url="https://github.com/Kaeptenblaubaer/BitemporalPostgres")
Pkg.add(url="https://github.com/GenieFramework/SearchLightPostgreSQL.jl")
Pkg.add("Intervals")
Pkg.add("TimeZones")
Pkg.add("Dates")
using Revise
using SearchLight
using SearchLightPostgreSQL

SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
SearchLight.Migrations.up()