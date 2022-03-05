module InsuranceContracts
import BitemporalPostgres
import SearchLight: DbId
import Base: @kwdef
export Contract, ContractRevision, ContractPartnerRef, ContractPartnerRefRevision
using BitemporalPostgres

"""
Contract

  a component of a bitemporal entity

"""
@kwdef mutable struct Contract <: BitemporalPostgres.Component
  id::DbId = DbId()
  ref_history :: DbId = InfinityKey  
  ref_version :: DbId = InfinityKey  
end

"""
ContractRevision

  a revision of a Contract component of a bitemporal entity

"""
@kwdef mutable struct ContractRevision <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = InfinityKey   
  ref_validfrom::DbId = InfinityKey 
  ref_invalidfrom::DbId = InfinityKey 
  description::String = ""
end

"""
ContractPartnerRef

  a component of a bitemporal entity

"""
@kwdef mutable struct ContractPartnerRef <: BitemporalPostgres.SubComponent
  id::DbId = DbId()
  ref_history :: DbId = InfinityKey  
  ref_version :: DbId = InfinityKey 
  ref_super :: DbId = InfinityKey  
end

"""
ContractPartnerRefRevision

  a revision of a Contract component of a bitemporal entity

"""
@kwdef mutable struct ContractPartnerRefRevision <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = InfinityKey   
  ref_validfrom::DbId = InfinityKey 
  ref_invalidfrom::DbId = InfinityKey 
  description::String = ""
  ref_partner::DbId = InfinityKey 
end

end
