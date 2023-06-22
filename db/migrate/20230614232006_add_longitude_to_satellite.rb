class AddLongitudeToSatellite < ActiveRecord::Migration[7.0]
  def change
    add_column :satellites, :longitude, :float
  end
end
