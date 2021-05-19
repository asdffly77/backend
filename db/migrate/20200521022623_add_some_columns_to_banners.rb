class AddSomeColumnsToBanners < ActiveRecord::Migration[6.0]
  def change
    add_column :banners, :banner_type, :integer, null: false, index: true, default: 0
  end
end
