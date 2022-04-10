module Expand

using Genie.Renderer.Html, Genie.Renderer, Stipple, StippleUI, StippleUI.API

@reactive mutable struct ExpansionModel <: ReactiveModel
    expanded::R{Bool} = true
end

function ui(model)
    layout(
        list(
            bordered = true,
            class = "rounded-borders",
            [
                expansionitem(
                    @bind(:expanded),
                    default_opened = true,
                    expandseparator = true,
                    icon = "perm_identity",
                    label = "Account settings",
                    caption = "John Doe",
                    [
                        card([
                            cardsection(
                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
                    commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
                    eveniet doloribus ullam aliquid.",
                            ),
                        ]),
                    ],
                ),
                expansionitem(
                    @bind(:expanded),
                    default_opened = true,
                    expandseparator = true,
                    icon = "signal_wifi_off",
                    label = "Wifi settings",
                    [
                        card([
                            cardsection(
                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
                    commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
                    eveniet doloribus ullam aliquid.",
                            ),
                        ]),
                    ],
                ),
                expansionitem(
                    @bind(:expanded),
                    default_opened = true,
                    expandseparator = true,
                    icon = "drafts",
                    label = "Drafts",
                    [
                        card([
                            cardsection(
                                "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
                    commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
                    eveniet doloribus ullam aliquid.",
                            ),
                        ]),
                    ],
                ),
            ],
        ),
    )
end

function handlers(model)
    on(model.isready) do _
        push!(model)
    end
    model
end

expansionmodel = handlers(Stipple.init(ExpansionModel; transport = Genie.WebThreads))


route("/") do
    html(ui(expansionmodel), context = @__MODULE__)
end

isrunning(:webserver) || up()
# Genie.config.log_requests = false
end #module