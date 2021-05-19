class AddVideoUrlToCases < ActiveRecord::Migration[6.0]
  def change
    add_column :cases, :video, :longtext
  end
end
