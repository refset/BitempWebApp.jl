using Genie, Genie.Router, Genie.Requests, Genie.Renderer
using Stipple, StippleUI
import Base: @kwdef


@kwdef mutable struct Person
    name::String = "Fliegner"
    given_name::String = "Michael"
end

@reactive mutable struct Name <: ReactiveModel
    name::R{Person} = Person()
end

function ui(model)
    layout(
        page(
            model,
            onload = "initTreeView()",
            class = "container",
            [
                h1([b
                    "Hello "
                    span("", @text(:name))
                ])
                row(
                    [
                      cell([btn("Less! ", @click("initTreeView()"))])
                    ]
                )
                li() do
                    "What is your name? "
                    input("", placeholder = "Type your name", @bind(Symbol("name.name")))
                    span(class = "caret")
                    ul(class = "nested") do
                        "What is your name? "
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("name.given_name"))
                        )
                    end
                end
                ul(
                    class = "caret",
                    [
                        "What is your name? "
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("name.given_name"))
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

route("/") do
    model = Name |> init
    html(ui(model), context = @__MODULE__)
end

up() # or `up(open_browser = true)` to automatically open a browser window/tab when launching the app