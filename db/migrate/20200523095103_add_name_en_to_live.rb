class AddNameEnToLive < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :name_en, :string
  end
end
