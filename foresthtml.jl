push!(LOAD_PATH, "app/resources/insurancecontracts")
using Genie.Renderer.Html,
    InsuranceContractsController,
    TimeZones,
    SearchLight,
    BitemporalPostgres,
    Genie,
    Genie.Router,
    Genie.Requests,
    Genie.Renderer.Json


SearchLight.Configuration.load() |> SearchLight.connect
hforest =
    mkforest(DbId(3), MaxDate, ZonedDateTime(1900, 1, 1, 0, 0, 0, 0, tz"UTC"), MaxDate)

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
        "Version $(string(node.interval.ref_version.value))" * if (!isempty(node.shadowed))
            renderhforest(node.shadowed, i + 1)
        else
            ""
        end
    end

end

route("/history", renderhistory)

Genie.up()