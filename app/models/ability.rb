# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, :state
    else
      can :read, :all
      cannot :read, :state
    end
  end
end
