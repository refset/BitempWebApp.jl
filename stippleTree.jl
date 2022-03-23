using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element


register_normal_element("q__tree", context = @__MODULE__)

function tree(args...; kwargs...)
  q__tree(args...; kw(kwargs)...)
end


@reactive mutable struct TreeModel <: ReactiveModel
  expanded::R{Vector{String}} = [ "Satisfied customers (with avatar)", "Good food (with icon)" ]
  children::R{Vector{Dict{String, String}}} = [
    Dict("label" => "Good food (with icon)", "label" => "Good recipe")
  ]
  simple::R{Vector{Vector{Dict{String, Union{String, Vector{Dict{String, String}}}}}}} = [
    [
     Dict( "label" => "Satisfied customers (with avatar)",
          "avatar" => "https://cdn.quasar.dev/img/boy-avatar.png",
          "children" => children)
    ],
  ]
end


function ui(tree_model)
  page(
    tree_model,
    title = "Tree Components",
    class = "container",
    [
       tree(:simple, nodekey="label")
    ],
  )
end

route("/") do
    tree_model = TreeModel |> init
    html(ui(tree_model), context = @__MODULE__)
end

up(async = true)