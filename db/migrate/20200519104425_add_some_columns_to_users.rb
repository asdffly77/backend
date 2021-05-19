class AddSomeColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_type, :integer, null: false, default: 0, index: false
    add_column :users, :user_remask, :string
    add_column :users, :company_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :name, :string
  end
end
