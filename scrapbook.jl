ENV["GENIE_ENV"] = "dev"
push!(LOAD_PATH, "app/resources/insurancecontracts")
using Pkg
Pkg.add("Revise")
using Revise
import Base: @kwdef
Pkg.add("BitemporalPostgres")
Pkg.add("HTTP")
Pkg.add("JSON")
Pkg.add("Test")
using Test
import InsuranceContractsController
using InsuranceContractsController.InsuranceContracts
using InsuranceContractsController.InsurancePartners
using BitemporalPostgres
using SearchLight
using TimeZones
using ToStruct
using JSON
using HTTP
using Genie, Genie.Router, Genie.Requests

@testset "scrapbook" begin

    SearchLight.Configuration.load() |> SearchLight.connect
    run(```psql -f sqlsnippets/droptables.sql```)
    SearchLight.Migrations.create_migrations_table()
    BitemporalPostgres.up()
    SearchLight.Migrations.up()
# create Partner
    p = Partner()
    pr = PartnerRevision(description = "blue")
    w = Workflow(
        tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    create_entity!(w)
    create_component!(p, pr, w)
    commit_workflow!(w)

# create Contract
    c = Contract()
    cr = ContractRevision(description = "blue")
    cpr = ContractPartnerRef(ref_super = c.id)
    cprr = ContractPartnerRefRevision(ref_partner = p.id, description = "blue")

    w1 = Workflow(
        tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    create_entity!(w1)
    create_component!(c, cr, w1)
    create_subcomponent!(c, cpr, cprr, w1)
    commit_workflow!(w1)

# update Contract yellow

    cr1 = ContractRevision(ref_component = c.id, description = "yellow")
    w2 = Workflow(
        ref_history = w1.ref_history,
        tsw_validfrom = ZonedDateTime(2016, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    update_entity!(w2)
    update_component!(cr, cr1, w2)
    commit_workflow!(w2)
    @test w2.ref_history == w1.ref_history

# update Contract red
    cr2 = ContractRevision(ref_component = c.id, description = "red")
    w3 = Workflow(
        ref_history = w2.ref_history,
        tsw_validfrom = ZonedDateTime(2015, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    update_entity!(w3)
    update_component!(cr1, cr2, w3)
    commit_workflow!(w3)
    @test w3.ref_history == w2.ref_history

    # end of mutations
end

hforest = mkforest(DbId(2), MaxDate, ZonedDateTime(1900, 1, 1, 0, 0, 0, 0, tz"UTC"), MaxDate)
print_tree(hforest)

