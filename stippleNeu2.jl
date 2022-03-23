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
            class = "container",
            [
                h1(
                    onload = "initTreeView()",
                    [
                        "Hello "
                        span("", @text(:name))
                    ],
                )
                ul(
                    class = "caret",
                    [
                        "1 What is your name? "
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("name.name"))
                        )
                        ul(
                            class = "nested",
                            [
                                "1 1 What is your name? "
                                input(
                                    "",
                                    placeholder = "Type your name",
                                    @bind(Symbol("name.given_name"))
                                )
                            ],
                        )
                    ],
                )
                ul(
                    class = "caret",
                    [
                        "2 What is your name? "
                        input(
                            "",
                            placeholder = "Type your name",
                            @bind(Symbol("name.given_name"))
                        )
                    ],
                )
                script("src=/js/application.js")
            ],
        ),
        head_content = """
          <title>Genie :: The highly productive MICHIS Julia web framework</title>
          <link href="/css/application.css" rel="stylesheet
          <script>
          function initTreeView() {
            var toggler = document.getElementsByClassName("caret");
            var i;
              alert("Moin, moin!")
              for (i = 0; i < toggler.length; i++) {
                toggler[i].addEventListener("click", function() {
                  this.parentElement.querySelector(".nested").classList.toggle("active");
                  this.classList.toggle("caret-down");
                });
              }
            }
bb
          </script>
          """,
    )
end

route("/") do
    model = Name |> init
    html(ui(model), context = @__MODULE__)
end

up() # or `up(open_browser = true)` to automatically open a browser window/tab when launching the app