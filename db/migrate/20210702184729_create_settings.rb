class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.string :eta_model
      t.string :eta_name
      t.string :eta_ip
      t.timestamps
    end
  end
end
