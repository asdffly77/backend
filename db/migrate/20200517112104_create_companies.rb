class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :company_classifies do |t|
      t.string :name, null: false, index: true
      t.string :name_en, null: false, index: true
      t.integer :classify_type, null:false, default: 0, index: true
    end
    create_table :company_classify_relations do |t|
      t.references :company, index: true
      t.references :company_classify, index: true
    end
    create_table :companies do |t|
      t.integer :company_type, null: false, default: 0, index: true
      t.string :name, index: true, unique: true
      t.string :name_en, index: true, unique: true
      t.string :description
      t.string :description_en
      t.longtext :detail
      t.longtext :detail_en
      t.references :company_classify_relations
      
      t.timestamps
    end
  end
end
