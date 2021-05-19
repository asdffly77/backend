class CreateFriendLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_links do |t|
      t.string :image
      t.string :name
      t.string :url
      
      t.timestamps
    end
  end
end
