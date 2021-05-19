class CreateMobileApps < ActiveRecord::Migration[6.0]
  def change
    create_table :mobile_apps do |t|
      t.integer :name
      t.string :version, :limit => 50
      t.string :secret, :limit => 32
      t.string :app_key, :limit => 32
      t.date :deprecated_at
      t.string :attachment 

      t.timestamps
    end
    add_index :mobile_apps, [:name, :version], :unique => true
    add_index :mobile_apps, :app_key
  end
end
