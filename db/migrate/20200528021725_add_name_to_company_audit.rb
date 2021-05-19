class AddNameToCompanyAudit < ActiveRecord::Migration[6.0]
  def change
    add_column :company_audits, :name, :string
    add_column :company_audits, :name_en, :string
  end
end
