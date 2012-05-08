class Ticket < ActiveRecord::Base
  attr_accessible :email, :ticket_time, :rate, :cell_number, :amount
  validate :ticket_time_is_valid, :email_is_valid, :amount_is_valid

  # amount is usually 50 or 60 
  def amount_is_valid
    errors.add(:amount, 'ticket amount is not right.  Please double check') if amount < 40 || amount > 200
  end

  def ticket_time_is_valid
    errors.add(:ticket_time, 'ticket time is not Right, please double check') if ticket_time >= Time.now
  end

#  def email_is_valid
#    errors.add(:email, 'email is not Right, please double check') unless email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
#  end

end
