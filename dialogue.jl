using HTTP
import ToStruct
import JSON

response = String(
    HTTP.request(
        "POST",
        "http://localhost:8000/jsonpayload",
        [("Content-Type", "application/json")],
        """{"command":"showsection"}""",
    ).body,
)
println(response)
result = ToStruct.tostruct(ContractSection, JSON.parse(response))
println(result)
