push!(LOAD_PATH,"app/resources/insurancecontracts")
import InsuranceContractsController
using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json


route("/") do
  serve_static_file("welcome.html")
end

route("/jsonpayload", method = POST) do
  if haskey(jsonpayload(),"command")
    if jsonpayload()["command"]=="csection"
      json(InsuranceContractsController.ContractSection())
    else
      json(Dict{String, Any}("error" => "only csection recognizable"))
    end
  else
    json(Dict{String, Any}("error" => "no command"))
  end
end

up()
