class State < ActiveRecord::Base
  has_one :receipt
  attr_accessible :description, :name

  def self.NONE
    State.find_by_name('NONE')
  end

  def self.PAYPAL_PAID
    State.find_by_name('PAYPAL PAID')
  end
end
