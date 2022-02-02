module CreateTableBitempWebApp
import BitemporalPostgres
import SearchLight: AbstractModel, DbId, query, save!
import SearchLight.Migrations: create_table, column, columns, primary_key, add_index, drop_table, add_indices
import SearchLightPostgreSQL
import Base: @kwdef
import Intervals, Dates, TimeZones
using Intervals, Dates, SearchLight, SearchLight.Transactions, SearchLightPostgreSQL, TimeZones
export up, down

function up()

  create_table(:contracts) do
      [
        column(:id,:bigserial,"PRIMARY KEY")
        column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
      ]
    end
  
  create_table(:contractRevisions) do
  [
    column(:id,:bigserial,"PRIMARY KEY")
    column(:ref_component, :integer, "REFERENCES contracts(id) ON DELETE CASCADE")
    column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
    column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
    column(:ref_valid, :int8range)
    column(:description, :string)
  ]
  end

  createContractRevisionsTrigger = """
  CREATE TRIGGER cr_versions_trig
  BEFORE INSERT OR UPDATE ON contractRevisions
  FOR EACH ROW EXECUTE PROCEDURE f_versionrange();
  """

  createContractRevisionsConstraints = """
  ALTER TABLE contractRevisions 
  ADD CONSTRAINT contractsversionrange EXCLUDE USING GIST (ref_component WITH =, ref_valid WITH &&)
  """    

  create_table(:partners) do
  [
    column(:id,:bigserial,"PRIMARY KEY")
    column(:ref_history, :integer,"REFERENCES histories(id) ON DELETE CASCADE")
  ]
  end

  create_table(:partnerRevisions) do
    [
      column(:id,:bigserial,"PRIMARY KEY")
      column(:ref_component, :integer, "REFERENCES partners(id) ON DELETE CASCADE")
      column(:ref_validfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
      column(:ref_invalidfrom, :integer, "REFERENCES versions(id) ON DELETE CASCADE")
      column(:ref_valid, :int8range)
      column(:description, :string)
    ]
  end

  createPartnerRevisionsTrigger = """
  CREATE TRIGGER pr_versions_trig
  BEFORE INSERT OR UPDATE ON partnerRevisions
  FOR EACH ROW EXECUTE PROCEDURE f_versionrange();
  """

  createPartnerRevisionsConstraints = """
  ALTER TABLE partnerRevisions 
  ADD CONSTRAINT partnersversionrange EXCLUDE USING GIST (ref_component WITH =, ref_valid WITH &&)
  """
    
  SearchLight.query(createContractRevisionsTrigger)
  SearchLight.query(createContractRevisionsConstraints)
  SearchLight.query(createPartnerRevisionsTrigger)
  SearchLight.query(createPartnerRevisionsConstraints)
end 

function down()
    drop_table(:contractRevisions)
    drop_table(:contracts)
    drop_table(:partnerRevisions)
    drop_table(:partners)
end 
end