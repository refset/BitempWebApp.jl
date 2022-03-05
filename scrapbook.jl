ENV["GENIE_ENV"]="dev"
push!(LOAD_PATH,"app/resources/insurancecontracts")
push!(LOAD_PATH,"app/resources/insurancepartners")
using Pkg
Pkg.add("Revise")
using Revise
import Base: @kwdef
Pkg.add("BitemporalPostgres")
Pkg.add("JSON")
import InsuranceContractsController
using InsuranceContractsController.InsuranceContracts
import InsurancePartnersController
using InsurancePartnersController.InsurancePartners
using BitemporalPostgres
using SearchLight
using TimeZones
using ToStruct
using JSON
SearchLight.Configuration.load() |> SearchLight.connect
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
ToStruct.tostruct(Contract,d)

@kwdef mutable struct PartnerSection 
    tsdb_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    tsw_validfrom::TimeZones.ZonedDateTime  = now(tz"UTC")
    ref_history::SearchLight.DbId = DbId(InfinityKey)
    ref_version::SearchLight.DbId = MaxVersion
    partner_revision::PartnerRevision = PartnerRevision()
end 

@kwdef mutable struct ContractSection 
    tsdb_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    tsw_validfrom::TimeZones.ZonedDateTime  = now(tz"UTC")
    ref_history::SearchLight.DbId = DbId(InfinityKey)
    ref_version::SearchLight.DbId = MaxVersion
    contract_revision::ContractRevision = ContractRevision()
    contractpartnerref_revision :: ContractPartnerRefRevision = ContractPartnerRefRevision()
    ref_entities:: Dict{DbId,Union{PartnerSection,ContractSection}} = Dict{DbId,Section}()
end 



psection=PartnerSection()
csection=ContractSection(ref_entities=(Dict(DbId(1)=>psection)))
bubu=ToStruct.tostruct(ContractSection,JSON.parse(json(csection)))
include("routes.jl")
ToStruct.tostruct(ContractSection,JSON.parse(String(HTTP.request("POST", "http://localhost:8000/jsonpayload", [("Content-Type", "application/json")], """{"name":"Adrian"}""").body)))

