class CreateBarrages < ActiveRecord::Migration[6.0]
  def change
    create_table :barrages do |t|
      t.references :user
      t.references :live
      t.string :detail

      t.timestamps
      t.index :created_at
    end
  end
end
