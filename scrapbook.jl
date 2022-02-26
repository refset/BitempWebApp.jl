ENV["GENIE_ENV"]="dev"
push!(LOAD_PATH,"app/resources/insurancecontracts")
push!(LOAD_PATH,"app/resources/insurancepartners")
using Pkg
Pkg.add(url="https://github.com/michaelfliegner/BitemporalPostgres.jl")
import InsuranceContractsController
using InsuranceContractsController
import InsurancePartnersController
using InsurancePartnersController
using BitemporalPostgres
using SearchLight
SearchLight.Configuration.load() |> SearchLight.connect

p=Partner()
pr=PartnerRevision(description="blue")
w=Workflow()
create_entity!(w)
create_component!(p,pr,w)
c=Contract()
cr=ContractRevision(description="blue")
cpr=ContractPartnerRef(ref_super=c.id)
cprr=ContractPartnerRefRevision(ref_partner=p.id,description="blue")
w=Workflow()
create_entity!(w)
create_component!(c,cr,w)
create_subcomponent!(c,cpr,cprr,w)
commit_workflow!(w)
