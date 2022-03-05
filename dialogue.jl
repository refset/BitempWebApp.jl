using HTTP
import ToStruct
import JSON
response=HTTP.request("POST", "http://localhost:8000/jsonpayload", [("Content-Type", "application/json")], """{"command":"csection"}""")
deserialized=ToStruct.tostruct(InsuranceContractsController.ContractSection,JSON.parse(String(response.body)))
response2=HTTP.request("POST", "http://localhost:8000/jsonpayload", [("Content-Type", "application/json")], JSON.json(deserialized))
deserialized2=ToStruct.tostruct(InsuranceContractsController.ContractSection,JSON.parse(String(response2.body)))

