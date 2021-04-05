class WeatherSyncService < SyncService
  ETA_LOCATION = 'Tuningen,de'

  def self.run
    new
  end

  def initialize
    api_key = Rails.application.credentials[:openweathermap][:api_key]
    uri = URI("https://api.openweathermap.org/data/2.5/weather?q=#{ETA_LOCATION}&APPID=#{api_key}&units=metric")
    response = make_request(uri)
    return unless response.code == '200'

    weather_data = JSON.parse(response.body)
    Weather.create!({
      temp: weather_data['main']['temp'],
      feels_like: weather_data['main']['feels_like'],
      temp_min: weather_data['main']['temp_min'],
      temp_max: weather_data['main']['temp_max'],
      humidity: weather_data['main']['humidity'],
      pressure: weather_data['main']['pressure'],
      wind_speed: weather_data['wind']['speed'],
      wind_deg: weather_data['wind']['deg'],
      wind_gust: weather_data['wind']['gust'],
      code: weather_data['weather'].first['id'],
      main: weather_data['weather'].first['main'],
      description: weather_data['weather'].first['description'],
      icon: weather_data['weather'].first['icon'],
      visibility: weather_data['visibility'],
      clouds: weather_data['clouds']['all'],
      weather_timestamp: weather_data['dt']})
  end

  private

  def make_request(uri, headers: nil)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
  end

  def storage_from_api

  end


end
