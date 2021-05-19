class AddSlotToLives < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :slot, :integer, default: 99
    add_index :lives, :slot
  end
end
