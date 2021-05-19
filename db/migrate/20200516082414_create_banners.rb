class CreateBanners < ActiveRecord::Migration[6.0]
  def change
    create_table :banners do |t|
      t.string :image
      t.datetime :start_at
      t.datetime :end_at
      t.integer :slot
      t.string :url

      t.timestamps
    end
  end
end
