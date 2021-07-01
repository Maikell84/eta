class CreateBuffers < ActiveRecord::Migration[6.1]
  def change
    create_table :buffers do |t|
      t.integer :value
      t.integer :sensor_1
      t.integer :sensor_2
      t.integer :sensor_3
      t.integer :sensor_4
      t.string :source, null: false
      t.timestamps
    end
  end
end
