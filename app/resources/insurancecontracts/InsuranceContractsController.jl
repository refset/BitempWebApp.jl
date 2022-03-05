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
    CntractSection(ref_entities = (Dict(DbId(1) => psection)))
end

end #module
