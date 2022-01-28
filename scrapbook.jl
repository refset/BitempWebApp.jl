module InsuranceContractsController
import BitemporalPostgres
include("InsurancePartner.jl")

    function createPartner()
        p = Partner()
        p
    end

end




module BitemporalPartner
import BitemporalPostgres
import SearchLight: DbId
import Base: @kwdef
export Partner, Partner_Revision
using BitemporalPostgres
"""
Partner

  a component of a bitemporal entity

"""
@kwdef mutable struct Partner <: Component
  id::DbId = DbId()
  ref_history :: DbId = infinityKey  
end

"""
Partner_Revision

  a revision of a Partner component of a bitemporal entity

"""
@kwdef mutable struct Partner_Revision <: Component_Revision
  id::DbId = DbId()
  ref_component :: DbId = infinityKey   
  ref_validfrom::DbId = infinityKey 
  ref_invalidfrom::DbId = infinityKey 
  description::String = ""
end

end