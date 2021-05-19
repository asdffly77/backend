class AddSomeColumnsToLive < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :image, :string
    add_column :lives, :status, :integer
    add_reference :lives, :company
    add_column :lives, :author, :string
  end
end
