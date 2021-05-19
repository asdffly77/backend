class AddUserReferenceToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :user
    add_column :companies, :phone_number, :string
  end
end
