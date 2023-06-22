class GetSatellitePosition < ApplicationJob
  queue_as :default
  N2YO_API_KEY = 'BPFUA7-HS2FP8-965FGB-51VG'

  def perform(satellite)
    n2yo_url = "https://api.n2yo.com/rest/v1/satellite/positions/#{satellite.satellite_id}/0/0/0/1/&apiKey=#{N2YO_API_KEY}"
    response = RestClient.get(n2yo_url)
    position = JSON.parse(response)["positions"].first
    set_position(position, satellite)
  end

  def set_position(position, satellite)
    satellite.latitude = position["satlatitude"]
    satellite.longitude = position["satlongitude"]
    satellite.save
  end
end
