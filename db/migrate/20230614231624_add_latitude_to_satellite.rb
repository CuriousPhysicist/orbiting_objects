class AddLatitudeToSatellite < ActiveRecord::Migration[7.0]
  def change
    add_column :satellites, :latitude, :float
  end
end
