import Base: @kwdef
Pkg.add("BitemporalPostgres")
Pkg.add("HTTP")
Pkg.add("JSON")
Pkg.add("TimeZones")
Pkg.add("ToStruct")
Pkg.add("Intervals")
Pkg.add("SearchLight")
Pkg.add("SearchLightPostgreSQL")
Pkg.add("Test")
using Test
import InsuranceContractsController
using InsuranceContractsController.InsuranceContracts
using InsuranceContractsController.InsurancePartners
using InsuranceContractsController.InsuranceTariffs
using BitemporalPostgres
using SearchLight
using TimeZones
using ToStruct
using JSON
using HTTP
using Genie, Genie.Router, Genie.Requests

@testset "CreateContract" begin

    SearchLight.Configuration.load() |> SearchLight.connect
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

# create Tariff
t = Tariff()
tr = TariffRevision(description = "blue")
w0 = Workflow(
    tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
)
create_entity!(w0)
create_component!(t, tr, w0)
commit_workflow!(w0)

# create Contract
    c = Contract()
    cr = ContractRevision(description = "blue")
    cpr = ContractPartnerRef(ref_super = c.id)
    cprr = ContractPartnerRefRevision(ref_partner = p.id, description = "blue")
    
    cpi = ProductItem(ref_super = c.id)
    cpir = ProductItemRevision(position=1,description="blue")
    
    pitr = ProductItemTariffRef(ref_super = cpi.id)
    pitrr = ProductItemTariffRefRevision(ref_tariff = t.id, description = "blue")

        
    pipr = ProductItemPartnerRef(ref_super = cpi.id)
    piprr = ProductItemPartnerRefRevision(ref_partner = p.id, description = "blue")

    w1 = Workflow(
        tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo"),
    )
    create_entity!(w1)
    create_component!(c, cr, w1)
    create_subcomponent!(c, cpr, cprr, w1)
    create_subcomponent!(c, cpi, cpir, w1)
    create_subcomponent!(cpi, pitr, pitrr, w1)
    create_subcomponent!(cpi, pipr, piprr, w1)
    commit_workflow!(w1)

end