class StorageSyncService < SyncService
  def self.run
    new
  end

  def initialize
    Storage.create(value: storage_from_api, source: 'cron')
  end

  private

  def storage_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10201/0/0/12015')
    response = make_request(uri)
    parse_request(response)
  end


end
