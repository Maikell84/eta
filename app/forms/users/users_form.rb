class Users::UsersForm < Form
  attr_reader :user

  attribute :firstname, auto_copy: :user
  attribute :lastname, auto_copy: :user
  attribute :email, auto_copy: :user

  def initialize(user = nil, attributes = {})
    @user = user || User.new
    super(attributes)
  end

  def process
    @user.save!
  end

  def new_record?
    @user.new_record?
  end
end
