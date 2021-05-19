class AddLanguageToBanners < ActiveRecord::Migration[6.0]
  def change
    add_column :banners, :language, :integer, :index => true, :default => 0
  end
end
