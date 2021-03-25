class Consumptions::ConsumptionForm < Form
  attr_reader :consumption

  attribute :value, auto_copy: :consumption
  attribute :source, auto_copy: :consumption
  attribute :created_at, auto_copy: :consumption

  def initialize(consumption = nil, attributes = {})
    @consumption = consumption || Consumption.new
    super(attributes)
  end

  def process
    @consumption.save!
  end

  def new_record?
    @consumption.new_record?
  end
end
