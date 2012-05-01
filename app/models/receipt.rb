class Receipt < ActiveRecord::Base
  attr_accessible :email, :expiration_time, :purchased_time, :rate, :total_paid, :cell_number
  validate :purchased_time_is_valid, :email_is_valid, :expiration_time_is_valid

  def expiration_time_is_valid
    errors.add(:expiration_time, 'expiration time is not Right, please double check') if expiration_time <= purchased_time
  end

  def purchased_time_is_valid
    errors.add(:purchased_time, 'purchased time is not Right, please double check') if purchased_time > Time.now
  end

  def email_is_valid
    errors.add(:email, 'email is not Right, please double check') unless email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
  end

  def self.search(search)
    self.where(search.conditions)
  end

end
