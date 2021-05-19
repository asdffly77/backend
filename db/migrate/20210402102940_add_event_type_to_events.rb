class AddEventTypeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_type, :integer
    add_index :events, :event_type
  end
end
