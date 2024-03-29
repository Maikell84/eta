class SyncService
  require 'nokogiri'
  require 'open-uri'

  protected

  def make_request(uri, use_ssl: false)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = use_ssl
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
  end

  def parse_request(response)
    doc = Nokogiri::XML(response.body)
    doc.remove_namespaces!
    doc.xpath("eta//value").attribute('strValue').value
  end
end
