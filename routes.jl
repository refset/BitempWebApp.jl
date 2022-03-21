
push!(LOAD_PATH,"app/resources/insurancecontracts")
import InsuranceContractsController
using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json


route("/") do
  serve_static_file("welcome.html")
end

route("/contracts", InsuranceContractsController.insurancecontracts_view) 

route("/history") do
  history_id = params(:history_id, "0")
  println("history_id= " * history_id)
  InsuranceContractsController.historyforest_view(parse(Int,history_id))
end

route("/csection") do
  history_id = params(:history_id, "0")
  version_id = params(:version_id, "0")
  println("history_id= " * history_id * " version_id= " * version_id)
  InsuranceContractsController.csection_view(parse(Int,history_id),parse(Int,version_id))
end


route("/jsonpayload", method = POST) do
  if haskey(jsonpayload(), "command")
      if jsonpayload()["command"] == "showsection"
          JSON.json(InsuranceContractsController.csection(3,3))
      else
          JSON.json(Dict{String,Any}("error" => "only showsection recognizable"))
      end
  else
      JSON.json(jsonpayload())
  end
end

Genie.up()
