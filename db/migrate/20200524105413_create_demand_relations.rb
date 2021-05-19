class CreateDemandRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :demand_relations do |t|
      t.references :company
      t.references :demand

      t.timestamps
    end
  end
end
