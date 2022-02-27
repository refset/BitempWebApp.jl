using BitempWebApp, Test
# implement your tests here
ENV["GENIE_ENV"]="dev"
push!(LOAD_PATH,"app/resources/insurancecontracts")
push!(LOAD_PATH,"app/resources/insurancepartners")
using Pkg
Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
Pkg.add("SearchLight")
Pkg.add("SearchLightPostgreSQL")
Pkg.add("ToStruct")
Pkg.add("JSON")
Pkg.add("TimeZones")
Pkg.add("Intervals")
import InsuranceContractsController
using InsuranceContractsController
import InsurancePartnersController
using InsurancePartnersController
using BitemporalPostgres
using SearchLight
using SearchLightPostgreSQL
using ToStruct
using JSON
using TimeZones
using Intervals


SearchLight.Configuration.load() |> SearchLight.connect
SearchLight.Migrations.create_migrations_table()
BitemporalPostgres.up()
SearchLight.Migrations.up()

p=Partner()
pr=PartnerRevision(description="blue")
w=Workflow()
w.tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo")
create_entity!(w)
create_component!(p,pr,w)
c=Contract()
cr=ContractRevision(description="blue")
cpr=ContractPartnerRef(ref_super=c.id)
cprr=ContractPartnerRefRevision(ref_partner=p.id,description="blue")
w=Workflow()
w.tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo")
create_entity!(w)
create_component!(c,cr,w)
create_subcomponent!(c,cpr,cprr,w)
commit_workflow!(w)

j=JSON.json(c)
d=JSON.parse(j)
c1 =ToStruct.tostruct(Contract,d)

@test c.id==c1.id