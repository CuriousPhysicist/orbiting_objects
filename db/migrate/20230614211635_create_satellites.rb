class CreateSatellites < ActiveRecord::Migration[7.0]
  def change
    create_table :satellites do |t|
      t.text :name
      t.integer :satellite_id

      t.timestamps
    end
  end
end
