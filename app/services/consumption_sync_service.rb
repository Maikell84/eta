class ConsumptionSyncService < SyncService
  def self.run
    new
  end

  def initialize
    Consumption.create(value: consumption_from_api, source: 'cron')
  end

  private

  def consumption_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12016')
    response = make_request(uri)
    parse_request(response)
  end
end
