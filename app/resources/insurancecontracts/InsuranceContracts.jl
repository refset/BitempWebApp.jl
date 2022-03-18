module InsuranceContracts
import BitemporalPostgres
import SearchLight: DbId
import Base: @kwdef
export Contract, ContractRevision, ContractPartnerRef, ContractPartnerRefRevision, ProductItem, ProductItemRevision, ProductItemTariffRef, ProductItemTariffRefRevision
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
ProductItem

  a component of a bitemporal contract entity

"""
@kwdef mutable struct ProductItem <: BitemporalPostgres.SubComponent
  id::DbId = DbId()
  ref_history :: DbId = InfinityKey  
  ref_version :: DbId = InfinityKey  
  ref_super :: DbId = InfinityKey  
end

"""
ProductItemRevision

  a revision of a ProductItem component of a bitemporal entity

"""
@kwdef mutable struct ProductItemRevision <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = InfinityKey
  position::Integer = 0 :: Int64
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


"""
ProductItemTariffRef

  a component of a bitemporal entity

"""
@kwdef mutable struct ProductItemTariffRef <: BitemporalPostgres.SubComponent
  id::DbId = DbId()
  ref_history :: DbId = InfinityKey  
  ref_version :: DbId = InfinityKey 
  ref_super :: DbId = InfinityKey  
end

"""
ProductItemTariffRefRevision

  a revision of a ProductItemTariffRef component of a bitemporal entity

"""
@kwdef mutable struct ProductItemTariffRefRevision  <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = InfinityKey   
  ref_validfrom::DbId = InfinityKey 
  ref_invalidfrom::DbId = InfinityKey 
  description::String = ""
  ref_tariff::DbId = InfinityKey 
end


"""
ProductItemPartnerRef

  a component of a bitemporal entity 

"""
@kwdef mutable struct ProductItemPartnerRef <: BitemporalPostgres.SubComponent
  id::DbId = DbId()
  ref_history :: DbId = InfinityKey  
  ref_version :: DbId = InfinityKey 
  ref_super :: DbId = InfinityKey  
end

"""
ProductItemPartnerRefRevision

  a revision of a ProductItemPartnerRef component of a bitemporal entity

"""
@kwdef mutable struct ProductItemPartnerRefRevision  <: BitemporalPostgres.ComponentRevision
  id::DbId = DbId()
  ref_component :: DbId = InfinityKey   
  ref_validfrom::DbId = InfinityKey 
  ref_invalidfrom::DbId = InfinityKey 
  description::String = ""
  ref_tariff::DbId = InfinityKey 
end

end
