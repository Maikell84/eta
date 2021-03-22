class Consumptions::ConumptionForm < Form
  attribute :value

  def initialize(a_consumption = nil, attributes = {})
    # @sampling_station = a_sampling_station || SarsCov::SamplingStation.new
    super(attributes)
  end
end
