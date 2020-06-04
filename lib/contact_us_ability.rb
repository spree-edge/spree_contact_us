# frozen_string_literal: true

class ContactUsAbility
  include CanCan::Ability

  def initialize(_user)
    can :read,   Spree::Inquiry
    can :index,  Spree::Inquiry
    can :create, Spree::Inquiry
  end
end
