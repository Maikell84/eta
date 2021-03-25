class WeatherSyncService < SyncService
  def self.run
    new
  end

  def initialize
  end

  private

  def make_request(uri, headers: nil)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["x-api-key"] = Settings.meteostat.api_key
    http.request(request)
  end

  def storage_from_api

  end


end
