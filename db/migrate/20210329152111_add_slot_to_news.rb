class AddSlotToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :slot, :integer, default: 0
    add_index :news, :slot
  end
end
