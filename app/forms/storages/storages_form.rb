class Storages::StoragesForm < Form
  attr_reader :storage

  attribute :value, auto_copy: :storage
  attribute :source, auto_copy: :storage
  attribute :created_at, auto_copy: :storage

  def initialize(storage = nil, attributes = {})
    @storage = storage || Storage.new
    super(attributes)
  end

  def process
    @storage.save!
  end

  def new_record?
    @storage.new_record?
  end
end
