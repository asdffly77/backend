class CreateLiveDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :live_details do |t|
      t.references :live
      t.string :image
      t.string :name
      t.string :name_en
      t.longtext :description
      t.longtext :description_en
      t.longtext :url

      t.timestamps
    end
  end
end
