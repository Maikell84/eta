class StorageSyncService
  require 'nokogiri'
  require 'open-uri'

  def self.run
    new
  end

  def initialize
    Storage.create(value: storage_from_api, source: 'daily_measurement')
    Consumption.create(value: consumption_from_api, source: 'daily_measurement')
  end

  private

  def storage_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10201/0/0/12015')
    response = make_request(uri)
    parse_request(response)
  end

  def consumption_from_api
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12016')
    response = make_request(uri)
    parse_request(response)
  end

  def make_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
  end

  def parse_request(response)
    doc = Nokogiri::XML(response.body)
    doc.remove_namespaces!
    doc.xpath("eta//value").attribute('strValue').value
  end
end
