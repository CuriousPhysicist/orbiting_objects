class Satellite < ApplicationRecord
  validates :satellite_id, uniqueness: true

  def position
    position = get_satellite_position(satellite_id)
    self.latitude = position["satlatitude"]
    self.longitude = position["satlongitude"]
    self.save
  end

  private

  N2YO_API_KEY = 'BPFUA7-HS2FP8-965FGB-51VG'

  def set_position
    position = get_satellite_position(satellite_id)
    self.latitude = position["satlatitude"]
    self.longitude = position["satlongitude"]
    self.save
  end

  def get_satellite_position(satellite_id)
      n2yo_url = "https://api.n2yo.com/rest/v1/satellite/positions/#{satellite_id}/0/0/0/1/&apiKey=#{N2YO_API_KEY}"
      response = RestClient.get(n2yo_url)
      JSON.parse(response)["positions"].first
  end
end
