module Bubu

using Genie.Renderer.Html, Genie.Renderer, Stipple, StippleUI

@reactive mutable struct Model <: ReactiveModel
    process::R{Bool} = false
    output::R{String} = ""
    input::R{String} = ""
    name::R{Vector{String}} = ["fliegner", "Burmeister"]
    given::R{Vector{String}} = ["michael", "irmgard"]
    age::R{Int} = 0
    warin::R{Bool} = true
end

function handlers(model)
    on(model.process) do _
        if (model.process[])
            model.output[] = model.input[] |> reverse
            model.given[1] = model.name[2] |> reverse
            model.given[2] = model.name[1] |> reverse
            println(
                "person" *
                model.name[1] *
                " " *
                model.name[2] *
                model.given[1] *
                " " *
                model.given[2],
            )
            model.process[] = false
        end
    end
    on(model.isready) do _
        push!(model)
    end
    model
end

function ui(model)
    pinputs = ""
    for i = 1:length(model.name[])
        pinputs =
            pinputs * p(
                [
                    "DynamicName Person $(i)"
                    input(
                        "",
                        @bind(Symbol("name[$(i-1)]")),
                        @on("keyup.enter", "process = true")
                    )
                ],
            )
        pinputs =
            pinputs * p(
                [
                    "Dynamic Given Person $(i)"
                    input(
                        "",
                        @bind(Symbol("given[$(i-1)]")),
                        @on("keyup.enter", "process = true")
                    )
                ],
            )
    end
    println("pinputs")
    println(pinputs)
    page(
        model,
        class = "container",
        [
            pinputs
            p([
                "Input "
                input("", @bind(:input), @on("keyup.enter", "process = true"))
            ])
            p(" {{todo}} {{index}}", class="warning", @recur(:"(todo,index) in name"))
            StippleUI.form(
                action = "/sub",
                method = "POST",
                [
                    textfield(
                        "What's your name *",
                        Symbol("name[0]"),
                        name = "name",
                        @iif(:warin),
                        :filled,
                        hint = "Name and surname",
                        "lazy-rules",
                        rules = "[val => val && val.length > 0 || 'Please type something']",
                    ),
                    numberfield(
                        "Your age *",
                        :age,
                        name = "age",
                        "filled",
                        :lazy__rules,
                        rules = "[val => val !== null && val !== '' || 'Please type your age',
                          val => val > 0 && val < 100 || 'Please type a real age']",
                    ),
                    btn("submit", type = "submit", color = "primary"),
                ],
            )
        ],
    )
end


model = handlers(Stipple.init(Model; transport = Genie.WebThreads))

route("/reactive") do
    html(ui(model), context = @__MODULE__)
end

route("/sub", method = POST) do
    age = params(:age, "99")
    name = params(:name, "Schnipperdey")
    println("PARAMS " * name * "  " * string(age))
    model.name = ["a", "b", "Schnipperdey"]
    redirect("/reactive")
end


isrunning(:webserver) || up()
end #module