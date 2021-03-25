class HomeController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]

  # GET /home or /home.json
  def index
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12016')
    response = make_request(uri)
    @total_consumption_now = parse_request(response)
    @consumption_yesterday = Consumption.where(created_at: 1.day.ago.beginning_of_day..1.day.ago.end_of_day)&.last&.value&.to_i
    return unless @consumption_yesterday.present?

    statistic
    @consumption_since_yesterday = @total_consumption_now.to_i - @consumption_yesterday
  end

  private

  def statistic
    grouped_consumptions = Consumption.where('created_at >= ?', 7.days.ago.beginning_of_day).group_by{|x| x.created_at.strftime("%Y-%m-%d")}

    @consumptions = []
    7.downto(0).each do |day|
      consumption_day = day.days.ago.beginning_of_day
      values_of_the_day = grouped_consumptions.dig(consumption_day.strftime("%Y-%m-%d")).pluck(:value)
      consumption_for_day = values_of_the_day.max - values_of_the_day.min
      @consumptions << OpenStruct.new(weekday: I18n.l(consumption_day, format: '%A'), day: consumption_day.strftime("%d.%m.%Y"), value: "#{consumption_for_day}kg")
    end
  end

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
