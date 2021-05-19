class AddAdShowToLive < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :ad_show, :boolean, :default => false
  end
end
