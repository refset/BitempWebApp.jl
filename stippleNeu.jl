using Genie, Genie.Router, Genie.Requests, Genie.Renderer
using Stipple, StippleUI
import Base: @kwdef


@kwdef mutable struct Person
    name::String = "FliegnerX"
    given_name::String = "Michael"
end

@reactive! mutable struct MFLModel <: ReactiveModel
    person::R{Person} = Person()
end


function ui(model)
    layout(
        page(
            model,
            class = "container",
            [
                h1([
                    "Hello "
                    span("", @text(Symbol("person.name")))
                ])
                ul(
                    class = "caret",
                    [
                        "What is your name? 1 "
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("person.name"))
                        )
                        if model.person.name == "Fliegner"
                            ul(
                                class = "caret",
                                [
                                    "What is your name? 1.1"
                                    input(
                                        "",
                                        placeholder = "Type your name",
                                        @bind(Symbol("person.given_name"))
                                    )
                                ],
                            )
                        else
                            ul(
                                class = "caret",
                                [
                                    "What is your hidden name? 1.1"
                                    input(
                                        "",
                                        placeholder = "Type your name",
                                        @bind(Symbol("person.given_name"))
                                    )
                                ],
                            )
                        end
                    ],
                )
                ul(
                    class = "caret",
                    [
                        "What is your name? 2"
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("person.given_name"))
                        )
                    ],
                )
            ],
        ),
        head_content = """
          <title>Genie :: The highly productive MICHIS Julia web framework</title>
          <link href="/css/application.css" rel="stylesheet">
          """,
    )
end

function start()
    global model
    route("/") do
        model = MFLModel |> init
        html(ui(model), context = @__MODULE__)
    end
    up() 
end

start()
# or `up(open_browser = true)` to automatically open a browser window/tab when launching the app
