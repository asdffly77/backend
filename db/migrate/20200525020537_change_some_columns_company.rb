class ChangeSomeColumnsCompany < ActiveRecord::Migration[6.0]
  def change
    change_column :companies, :description_en, :text
    change_column :companies, :description, :text
  end
end
