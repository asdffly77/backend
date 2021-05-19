class AddSomeColumnsToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :status, :integer, null: false, default: 0, index: true
    add_column :companies, :recommended, :integer, null: false, default: 0, index: true
    add_column :companies, :logo, :string
  end
end
