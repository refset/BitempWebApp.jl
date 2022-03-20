function get_component(type::Type{T}, hid::SearchLight.DbId) where {T <: Component}
    find(type,SQLWhereExpression("ref_history=?",3))[1]
end
function get_revision(type::Type{T}, cid::DbId, vid::DbId) where {T <: ComponentRevision}
    find(type,SQLWhereExpression("ref_component=? and ref_valid  @> BIGINT ?",cid,vid))[1]
end
SearchLight.Configuration.load() |> SearchLight.connect

c=get_component(Contract,DbId(3))
cr=get_revision(ContractRevision,c.id, DbId(3))
pr=get_component(ContractPartnerRef,DbId(3))
prr=get_revision(ContractPartnerRefRevision,pi.id, DbId(3))
pi=get_component(ProductItem,DbId(3))
pir=get_revision(ProductItemRevision,pi.id, DbId(3))
pit=get_component(ProductItemTariffRef,DbId(3))
pitr=get_revision(ProductItemTariffRefRevision,pit.id, DbId(3))
pip=get_component(ProductItemPartnerRef,DbId(3))
pipr=get_revision(ProductItemPartnerRefRevision,pip.id, DbId(3))

