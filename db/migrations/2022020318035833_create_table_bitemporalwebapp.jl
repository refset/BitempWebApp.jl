module CreateTableBitempWebApp
import SearchLight: AbstractModel, DbId, query, save!
import SearchLight.Migrations:
    create_table, column, columns, primary_key, add_index, drop_table, add_indices
import SearchLightPostgreSQL
import Base: @kwdef
import Intervals, Dates, TimeZones
using Intervals,
    Dates, SearchLight, SearchLight.Transactions, SearchLightPostgreSQL, TimeZones
export up, down

function createRevisionsTriggerAndConstraint(
    trigger::Symbol,
    constraint::Symbol,
    table::Symbol,
)
    SearchLight.query("""
                      CREATE TRIGGER $trigger
                      BEFORE INSERT OR UPDATE ON $table
                      FOR EACH ROW EXECUTE PROCEDURE f_versionrange();
                      """)
    SearchLight.query(
        """
        ALTER TABLE $table
        ADD CONSTRAINT $constraint EXCLUDE USING GIST (ref_component WITH =, ref_valid WITH &&)
        """,
    )
end

function up()

    create_table(:contracts) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        ]
    end

    create_table(:contractRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_component, :integer, "REFERENCES contracts(id) ON DELETE CASCADE")
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
        ]
    end

    createRevisionsTriggerAndConstraint(
        :cr_versions_trig,
        :contractsversionrange,
        :contractRevisions,
    )

    create_table(:productItems) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_super, :integer, "REFERENCES contracts(id) ON DELETE CASCADE")
        ]
    end

    create_table(:productItemRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(
                :ref_component,
                :integer,
                "REFERENCES productitems(id) ON DELETE CASCADE",
            )
            column(:position, :integer)
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
        ]
    end

    createRevisionsTriggerAndConstraint(
        :pi_versions_trig,
        :pi_versionrange,
        :productitemRevisions,
    )

    create_table(:partners) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        ]
    end

    create_table(:partnerRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_component, :integer, "REFERENCES partners(id) ON DELETE CASCADE")
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
        ]
    end

    createRevisionsTriggerAndConstraint(
        :pr_versions_trig,
        :pr_versionrange,
        :partnerRevisions,
    )

    create_table(:contractPartnerRefs) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_super, :integer, "REFERENCES contracts(id) ON DELETE CASCADE")
        ]
    end

    create_table(:contractPartnerRefRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(
                :ref_component,
                :integer,
                "REFERENCES contractPartnerRefs(id) ON DELETE CASCADE",
            )
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
            column(:ref_partner, :integer, "REFERENCES partners(id) ON DELETE CASCADE")
        ]
    end

    createRevisionsTriggerAndConstraint(
        :cprr_versions_trig,
        :cprr_versionrange,
        :contractPartnerRefRevisions,
    )

    create_table(:tariffs) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
        ]
    end

    create_table(:tariffRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_component, :integer, "REFERENCES tariffs(id) ON DELETE CASCADE")
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
        ]
    end

    createRevisionsTriggerAndConstraint(
        :tr_versions_trig,
        :tr_versionrange,
        :tariffRevisions,
    )

    create_table(:productItemTariffRefs) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_super, :integer, "REFERENCES productitems(id) ON DELETE CASCADE")
        ]
    end

    create_table(:productItemTariffRefRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(
                :ref_component,
                :integer,
                "REFERENCES productItemTariffRefs(id) ON DELETE CASCADE",
            )
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
            column(:ref_tariff, :integer, "REFERENCES tariffs(id) ON DELETE CASCADE")
        ]
    end

    createRevisionsTriggerAndConstraint(
        :pitrr_versions_trig,
        :pitrr_versionrange,
        :productItemTariffRefRevisions,
    )

    create_table(:productItemPartnerRefs) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(:ref_history, :integer, "REFERENCES histories(id) ON DELETE CASCADE")
            column(:ref_version, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_super, :integer, "REFERENCES productitems(id) ON DELETE CASCADE")
        ]
    end

    create_table(:productItemPartnerRefRevisions) do
        [
            column(:id, :bigserial, "PRIMARY KEY")
            column(
                :ref_component,
                :integer,
                "REFERENCES productItemPartnerRefs(id) ON DELETE CASCADE",
            )
            column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
            column(:ref_valid, :int8range)
            column(:description, :string)
            column(:ref_partner, :integer, "REFERENCES partners(id) ON DELETE CASCADE")
        ]
    end

    createRevisionsTriggerAndConstraint(
        :piprr_versions_trig,
        :piprr_versionrange,
        :productItemPartnerRefRevisions,
    )

end

function down()
    BitemporalPostgres.DDL.down()
    drop_table(:contractRevisions)
    drop_table(:contracts)
    drop_table(:contractProductItems)
    drop_table(:contractProductItemRevisions)
    drop_table(:contractPartnerRefRevisions)
    drop_table(:contractPartnerRefs)
    drop_table(:productItemTariffRefRevisions)
    drop_table(:productItemTariffRefs)
    drop_table(:productItemPartnerRefRevisions)
    drop_table(:productItemPartnerRefs)
    drop_table(:partnerRevisions)
    drop_table(:partners)
    drop_table(:tariffRevisions)
    drop_table(:tariffs)

end
end
