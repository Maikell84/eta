class AshSyncService < SyncService
  def self.run
    new
  end

  def initialize
    Ash.create(value: ash_from_api, source: 'cron')
  end

  private

  def ash_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12013')
    response = make_request(uri)
    parse_request(response)
  end


end
