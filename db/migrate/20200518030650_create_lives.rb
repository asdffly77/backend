class CreateLives < ActiveRecord::Migration[6.0]
  def change
    create_table :lives do |t|
      t.integer :live_type
      t.string :name, index: true, null: false
      t.string :description
      t.string :stream_key
      

      t.timestamps
    end
  end
end
