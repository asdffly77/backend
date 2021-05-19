class CreateLiveSubscribes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_live_subscribes do |t|
      t.references :user
      t.references :live
      
      t.timestamps
    end
  end
end
