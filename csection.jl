function get_revision(
    ctype::Type{CT},
    rtype::Type{RT},
    hid::DbId,
    vid::DbId,
) where {CT<:Component,RT<:ComponentRevision}
    find(
        rtype,
        SQLWhereExpression(
            "ref_component=? and ref_valid  @> BIGINT ?",
            find(ctype, SQLWhereExpression("ref_history=?", hid))[1].id,
            vid,
        ),
    )[1]
end

SearchLight.Configuration.load() |> SearchLight.connect
history_id = DbId(3)
version_id = DbId(3)
csect = ContractSection(
    ref_history = history_id,
    ref_version = version_id,
    contract_revision = get_revision(Contract, ContractRevision, history_id, version_id),
    contractpartnerref_revision = get_revision(
        ContractPartnerRef,
        ContractPartnerRefRevision,
        history_id,
        version_id,
    ),
    productitem_revision = get_revision(
        ProductItem,
        ProductItemRevision,
        history_id,
        version_id,
    ),
    productitem_tariffref_revision = get_revision(
        ProductItemTariffRef,
        ProductItemTariffRefRevision,
        history_id,
        version_id,
    ),
    productitem_partnerref_revision = get_revision(
        ProductItemPartnerRef,
        ProductItemPartnerRefRevision,
        history_id,
        version_id,
    ),
    ref_entities = Dict{DbId,Union{PartnerSection,ContractSection,TariffSection}}(
        DbId(1) => PartnerSection(
            partner_revision = get_revision(Partner, PartnerRevision, DbId(1), DbId(1)),
        ),
        DbId(2) => TariffSection(
            tariff_revision = get_revision(Tariff, TariffRevision, DbId(2), DbId(2)),
        ),
    ),
)


