class StatesController < ApplicationController
  include EtaApi

  def index
    @ash = Ash.last
    @storage = Storage.last
    @current_heating_storage = current_heating_storage
    @current_buffer_charge_level = current_buffer_charge_level
    @current_pressure = current_pressure.gsub(',', '.').to_f
    @current_load = current_load
  end

  private

  def current_heating_storage
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/0/12011')
    response = make_request(uri)
    parse_request(response)
  end

  def current_buffer_charge_level
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/0/12528')
    response = make_request(uri)
    parse_request(response)
  end

  def current_pressure
    uri = URI('http://192.168.1.23:8080/user/var/40/10021/0/11135/0')
    response = make_request(uri)
    parse_request(response)
  end

  def current_load
    uri = URI('http://192.168.1.23:8080/user/var//120/10101/0/0/13100')
    response = make_request(uri)
    parse_request(response)
  end
end
