class AddSomeColumnToCases < ActiveRecord::Migration[6.0]
  def change
    add_column :cases, :name_en, :string, index: true
  end
end
