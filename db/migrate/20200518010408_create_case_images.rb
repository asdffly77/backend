class CreateCaseImages < ActiveRecord::Migration[6.0]
  def change
    create_table :case_images do |t|
      t.string :image
      t.references :case

      t.timestamps
    end
  end
end
