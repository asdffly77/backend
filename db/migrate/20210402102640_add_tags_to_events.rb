class AddTagsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :tags, :string
  end
end
