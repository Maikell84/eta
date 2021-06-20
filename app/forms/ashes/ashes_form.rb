class Ashes::AshesForm < Form
  attr_reader :ash

  attribute :value, auto_copy: :ash
  attribute :source, auto_copy: :ash
  attribute :created_at, auto_copy: :ash

  def initialize(ash = nil, attributes = {})
    @ash = ash || Ash.new
    super(attributes)
  end

  def process
    @ash.save!
  end

  def new_record?
    @ash.new_record?
  end
end
