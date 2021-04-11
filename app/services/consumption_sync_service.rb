class ConsumptionSyncService < SyncService
  def self.run
    new
  end

  def initialize
    weather_data = WeatherSyncService.new.run
    ActiveRecord::Base.transaction do
      consumption = Consumption.create!(value: consumption_from_api, source: 'cron')


      if weather_data.present?
        # TODO: Fix this
        Weather.create!({
                          consumption: consumption,
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
    end
  end

  private

  def consumption_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12016')
    response = make_request(uri)
    parse_request(response)
  end
end
