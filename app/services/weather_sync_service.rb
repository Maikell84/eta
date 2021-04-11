class WeatherSyncService < SyncService
  attr_reader :api_key
  ETA_LOCATION = 'Tuningen,de'

  def self.run
    new
  end

  def initialize
    @api_key = Rails.application.credentials[:openweathermap][:api_key]
  end

  def run
    uri = URI("https://api.openweathermap.org/data/2.5/weather?q=#{ETA_LOCATION}&APPID=#{api_key}&units=metric")
    response = make_request(uri, use_ssl: true)
    return unless response.code == '200'

    JSON.parse(response.body)

    # TODO - Better error handling
  rescue StandardError => e
    Rails.logger.error("Weather api error: #{e.message}")
    false
  end
end
