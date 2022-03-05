module InsuranceContractsController
import Base: @kwdef
import TimeZones
using TimeZones
import ToStruct
using ToStruct
import JSON
using JSON
import SearchLight
using SearchLight
import BitemporalPostgres
using BitemporalPostgres
include("InsuranceContracts.jl")
using .InsuranceContracts
export Contract, ContractRevision, ContractPartnerRef, ContractPartnerRefRevision
include("InsurancePartners.jl")
using ..InsurancePartners
export Partner, PartnerRevision
export ContractSection, PartnerSection,csection

@kwdef mutable struct PartnerSection
    tsdb_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    tsw_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    ref_history::SearchLight.DbId = DbId(InfinityKey)
    ref_version::SearchLight.DbId = MaxVersion
    partner_revision::PartnerRevision = PartnerRevision()
end

@kwdef mutable struct ContractSection
    tsdb_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    tsw_validfrom::TimeZones.ZonedDateTime = now(tz"UTC")
    ref_history::SearchLight.DbId = DbId(InfinityKey)
    ref_version::SearchLight.DbId = MaxVersion
    contract_revision::ContractRevision = ContractRevision()
    contractpartnerref_revision::ContractPartnerRefRevision = ContractPartnerRefRevision()
    ref_entities::Dict{DbId,Union{PartnerSection,ContractSection}} = Dict{DbId,Union{PartnerSection,ContractSection}}()
end


function csection()
    psection = PartnerSection()
    ContractSection(ref_entities = (Dict(DbId(1) => psection)))
end

function createContract()
    SearchLight.Configuration.load() |> SearchLight.connect
    p=Partner()
    pr=PartnerRevision(description="blue")
    w=Workflow()
    w.tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo")
    create_entity!(w)
    create_component!(p,pr,w)
    psection = PartnerSection(partner_revision=pr,ref_version=w.ref_version)
    c=Contract()
    cr=ContractRevision(description="blue")
    cpr=ContractPartnerRef(ref_super=c.id)
    cprr=ContractPartnerRefRevision(ref_partner=p.id,description="blue")
    w=Workflow()
    w.tsw_validfrom = ZonedDateTime(2014, 5, 30, 21, 0, 1, 1, tz"Africa/Porto-Novo")
    create_entity!(w)
    create_component!(c,cr,w)
    create_subcomponent!(c,cpr,cprr,w)
    ContractSection(ref_version=w.ref_version, contract_revision=cr, contractpartnerref_revision= cprr, ref_entities = (Dict(p.id => psection)))
end

end #module
