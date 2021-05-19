class CreateCompanyAudits < ActiveRecord::Migration[6.0]
  def change
    create_table :company_audits do |t|
      t.references :company
      t.string :description
      t.string :description_en
      t.longtext :detail
      t.longtext :detail_en

      t.timestamps
    end
  end
end
