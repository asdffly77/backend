class AddSlotToDemands < ActiveRecord::Migration[6.0]
  def change
    add_column :demands, :slot, :integer, default: 0
    add_index :demands, :slot
  end
end
