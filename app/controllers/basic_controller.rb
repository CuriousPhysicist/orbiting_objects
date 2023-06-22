class BasicController < ApplicationController
  @@temporary_store = []

  def index
    @satellites = @@temporary_store
  end

  def get_satellites
    @@temporary_store = get_target_satellites
    redirect_to controller: "basic", action: "index"
  end

  private

  def instantiate(satellites)
    satellites.each do |satallite_data|
      satellite = Satellite.new(name: satallite_data["name"], satellite_id: satallite_data["satelliteId"].to_i)
      satellite.save
    end
  end

  def get_target_satellites
    nasa_url = 'https://tle.ivanstanojevic.me/api/tle/'
    response = RestClient.get(nasa_url)
    target_satellites = JSON.parse(response)["member"]
    instantiate(target_satellites)

    target_satellites
  end
end
