class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :new_classifies do |t|
      t.string :name
      t.string :name_en

    end
    create_table :news do |t|
      t.string :name
      t.string :name_en

      t.longtext :detail
      t.longtext :detail_en

      t.datetime :start_at
      t.datetime :end_at

      t.integer :new_type, null: false, default: 0, index: true
      t.string :image 
      t.references :new_classify
      t.timestamps
    end
  end
end
