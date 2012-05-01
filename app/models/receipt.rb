class Receipt < ActiveRecord::Base
  attr_accessible :email, :expiration_time, :purchased_time, :rate
  validate :purchased_time_is_valid

  def purchased_time_is_valid
    errors.add(:purchased_time, 'purchased time is not Right, please double check') if purchased_time >= Time.now
  end

  def self.search(search)
    self.where(search.conditions)
  end
end
