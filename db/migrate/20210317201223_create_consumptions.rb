class CreateConsumptions < ActiveRecord::Migration[6.1]
  def change
    create_table :consumptions do |t|
      t.integer :value, null: false
      t.string :source, null: false
      t.timestamps
    end
  end
end
