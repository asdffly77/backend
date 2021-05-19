class AddSourceToLives < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :source, :integer, :index => true, :default => 0
    add_column :lives, :source_url, :longtext
  end
end
