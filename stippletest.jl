using Genie, Genie.Router, Genie.Renderer.Html, Stipple

Base.@kwdef mutable struct Name <: ReactiveModel
  name::R{String} = "World!"
end

model = Stipple.init(Name)

function ui()
  page(
    root(model), class="container", [
      h1([
        "Hello "
        span("", @text(:name))
      ])

      p([
        "What is your name? "
        input("", placeholder="Type your name", @bind(:name))
      ])
    ], title="Basic Stipple"
  ) |> html
end

route("/", ui)

up()