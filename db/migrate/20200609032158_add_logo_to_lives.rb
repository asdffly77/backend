class AddLogoToLives < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :logo, :string
  end
end
