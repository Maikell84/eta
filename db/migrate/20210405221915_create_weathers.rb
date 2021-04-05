class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.decimal :temp, precision: 10, scale: 2
      t.decimal :feels_like, precision: 10, scale: 2
      t.decimal :temp_min, precision: 10, scale: 2
      t.decimal :temp_max, precision: 10, scale: 2
      t.decimal :humidity, precision: 10, scale: 2
      t.decimal :pressure, precision: 10, scale: 2
      t.decimal :wind_speed, precision: 10, scale: 2
      t.decimal :wind_deg, precision: 10, scale: 2
      t.decimal :wind_gust, precision: 10, scale: 2
      t.integer :code
      t.string :main
      t.string :description
      t.string :icon
      t.integer :visibility
      t.integer :clouds
      t.datetime :weather_timestamp
      t.timestamps
    end
  end
end
