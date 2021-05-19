class AddStatusToCompanyAudits < ActiveRecord::Migration[6.0]
  def change
    add_column :company_audits, :status, :integer, :null => false, :index => true, :default => 0
  end
end
