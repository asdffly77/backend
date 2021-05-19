class AddSlotToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :slot, :integer, :index => true, :default => 0
  end
end
