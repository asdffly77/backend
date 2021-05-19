class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string  :title
      t.string  :url
      t.string  :time
      t.integer :slot, default: 0

      t.timestamps
    end

    add_index :events, :slot
  end
end
