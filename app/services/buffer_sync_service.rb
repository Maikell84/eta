class BufferSyncService < SyncService
  BufferValue = Struct.new(:buffer_value, :sensor_1, :sensor_2, :sensor_3, :sensor_4, keyword_init: true)

  def self.run
    new
  end

  def initialize
    buffer_value = buffer_values_from_api
    Buffer.create(value: buffer_value.buffer_value,
                  sensor_1: buffer_value.sensor_1,
                  sensor_2: buffer_value.sensor_2,
                  sensor_3: buffer_value.sensor_3,
                  sensor_4: buffer_value.sensor_4,
                  source: 'cron')
  end

  private

  def buffer_values_from_api
    buffer_value = BufferValue.new
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/11327/0') # sensor 1
    response = make_request(uri)
    buffer_value.sensor_1 = parse_request(response)
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/11328/0') # sensor 2
    response = make_request(uri)
    buffer_value.sensor_2 = parse_request(response)
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/11329/0') # sensor 3
    response = make_request(uri)
    buffer_value.sensor_3 = parse_request(response)
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/11330/0') # sensor 4
    response = make_request(uri)
    buffer_value.sensor_4 = parse_request(response)
    uri = URI('http://192.168.1.23:8080/user/var/120/10601/0/0/12528') # buffer value
    response = make_request(uri)
    buffer_value.buffer_value = parse_request(response)

    buffer_value
  end

end
