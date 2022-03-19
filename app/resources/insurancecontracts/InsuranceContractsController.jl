module InsuranceContractsController
using Genie.Renderer.Html

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
export Contract, ContractRevision, ContractPartnerRef, ContractPartnerRefRevision, ProductItem, ProductItemRevision, ProductItemTariffRef, ProductItemTariffRefRevision
include("InsurancePartners.jl")
using .InsurancePartners
export Partner, PartnerRevision
include("InsuranceTariffs.jl")
using .InsuranceTariffs
export Tariff, TariffRevision
export ContractSection, PartnerSection,csection
export insurancecontracts_view

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

function insurancecontracts_view()
    html(:insurancecontracts, :insurancecontracts, contracts = all(ContractRevision))
  end

function renderhistory()
    [
        Html.h1() do
            "Billiam Gates' list of recommended books"
        end
        renderhforest(hforest, 0)
    ]

end

function renderhforest(f, i)
    Html.ul() do
        for_each(f) do node
            renderhnode(node, i + 1)
        end
    end
end

function renderhnode(node, i)
    Html.li() do
        "Version $(string(node.interval.ref_version.value))" *
        if (!isempty(node.shadowed))
            renderhforest(node.shadowed, i+1)
        else ""
        end
    end

end


renderhistory()


end #module
