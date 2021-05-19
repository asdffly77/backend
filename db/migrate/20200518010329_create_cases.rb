class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.string :name, index: true
      t.longtext :detail
      t.longtext :detail_en
      t.string :three_d_model
      t.references :company

      t.timestamps
    end
  end
end
