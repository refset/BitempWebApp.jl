using Stipple

@reactive mutable struct Name <: ReactiveModel
  name::R{Vector{String}} = ["World!","Heaven"]
end

function ui(model)
  page( model, class="container", [
      h1([
        "Hello "
        span("", @text(:name))
      ])

      p([
        "What is your name? "
        input("", placeholder="Type your name", @bind(Symbol("name[0]")))
      ])

      p([
        "What is your name? "
        input("", placeholder="Type your name", @bind(Symbol("name[1]")))
      ])

    ]
  )
end

route("/") do
  model = Name |> init
  html(ui(model), context = @__MODULE__)
end

up() # or `up(open_browser = true)` to automatically open a browser window/tab when launching the app