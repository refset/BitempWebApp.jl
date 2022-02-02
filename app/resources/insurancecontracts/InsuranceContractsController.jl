module InsuranceContractsController
import BitemporalPostgres
import SearchLight: DbId
import Base: @kwdef
export Contract, ContractRevision
using BitemporalPostgres

"""
Contract

  a component of a bitemporal entity

"""
@kwdef mutable struct Contract <: BitemporalPostgres.Component
  id::DbId = DbId()
  ref_history :: DbId = infinityKey  
end

"""
ContractRevision

  a revision of a Contract component of a bitemporal entity

"""
@kwdef mutable struct ContractRevision <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = infinityKey   
  ref_validfrom::DbId = infinityKey 
  ref_invalidfrom::DbId = infinityKey 
  description::String = ""
end

end
