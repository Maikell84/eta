class HomeController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]

  # GET /home or /home.json
  def index
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12016')
    response = make_request(uri)
    @total_consumption_now = parse_request(response)
    @consumption_yesterday = Consumption.where(created_at: 1.day.ago.beginning_of_day..1.day.ago.end_of_day)&.last&.value&.to_i
    return unless @consumption_yesterday.present?

    @consumption_since_yesterday = @total_consumption_now.to_i - @consumption_yesterday
  end

  private

  # TODO DRY
  def make_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
  end

  # TODO DRY
  def parse_request(response)
    doc = Nokogiri::XML(response.body)
    doc.remove_namespaces!
    doc.xpath("eta//value").attribute('strValue').value
  end

end
