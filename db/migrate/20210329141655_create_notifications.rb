class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.text    :body
      t.boolean :is_active, default: false

      t.timestamps
    end

    add_index :notifications, :is_active
  end
end
