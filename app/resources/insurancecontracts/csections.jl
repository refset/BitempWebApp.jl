j = JSON.json(c)
d = JSON.parse(j)
ToStruct.tostruct(Contract, d)

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
    contractpartnerref_revision::ContractPartnerRefRevision =
        ContractPartnerRefRevision()
    ref_entities::Dict{DbId,Union{PartnerSection,ContractSection}} =
        Dict{DbId,Section}()
end



psection = PartnerSection()
csection = ContractSection(ref_entities = (Dict(DbId(1) => psection)))
bubu = ToStruct.tostruct(ContractSection, JSON.parse(JSON.json(csection)))

route("/jsonpayload", method = POST) do
    if haskey(jsonpayload(), "command")
        if jsonpayload()["command"] == "createContract"
            JSON.json(InsuranceContractsController.createContract())
        else
            JSON.json(Dict{String,Any}("error" => "only createContract recognizable"))
        end
    else
        JSON.json(jsonpayload())
    end
end
end
Genie.up()

response = String(
HTTP.request(
    "POST",
    "http://localhost:8000/jsonpayload",
    [("Content-Type", "application/json")],
    """{"command":"createContract"}""",
).body,
)
println(response)
result = ToStruct.tostruct(ContractSection, JSON.parse(response))
println(result)
