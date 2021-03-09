class StorageSyncService
  require 'nokogiri'
  require 'open-uri'

  def self.run
    new
  end

  def initialize
    uri = URI('http://192.168.1.23:8080/user/var/40/10201/0/0/12015')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    doc  = Nokogiri::XML(response.body)
    doc.remove_namespaces!
    value = doc.xpath("eta//value").attribute('strValue').value

    Storage.create(value: value, source: 'daily_measurement')
  end
end
