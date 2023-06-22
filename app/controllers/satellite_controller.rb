class SatelliteController < ApplicationController
  def index
    @satellites = Satellite.all
  end

  def show
    @satellite ||= Satellite.find(params["id"])
    @satellite.position
  end

  def create
    satellites = satellite_params.map do |satellite_data|
      puts satellite_data.class
      Satellite.new(satellite_data)
    end
    satellites.map(&:save)
  end

  private
    # Only allow a list of trusted parameters through.
    def satellite_params
      params["_json"].map { |data| data.slice(:name, :satellite_id).permit(:name, :satellite_id) }
    end
end
