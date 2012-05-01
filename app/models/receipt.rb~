class Receipt < ActiveRecord::Base
  attr_accessible :email, :expiration_time, :purchased_time, :rate

  def self.search(search)
    self.where(search.conditions)
  end
end
