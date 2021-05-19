class CreateCaseAndits < ActiveRecord::Migration[6.0]
  def change
    create_table :case_andits do |t|
      t.longtext :detail
      t.longtext :detail_en
      t.references :case

      t.timestamps
    end
  end
end
