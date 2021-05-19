class AddPhoneNumberToCompanyAudit < ActiveRecord::Migration[6.0]
  def change
    add_column :company_audits, :phone_number, :string
  end
end
