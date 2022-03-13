
push!(LOAD_PATH,"app/resources/insurancecontracts")
import InsuranceContractsController
using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json


route("/") do
  serve_static_file("welcome.html")
end

route("/contracts", InsuranceContractsController.insurancecontracts_view)

route("/jsonpayload", method = POST) do
  if haskey(jsonpayload(),"command")
    if jsonpayload()["command"]=="createContract"
      json(InsuranceContractsController.createContract())
    else
      json(Dict{String, Any}("error" => "only csection recognizable"))
    end
  else
    json(jsonpayload())
  end
end

Genie.up()
