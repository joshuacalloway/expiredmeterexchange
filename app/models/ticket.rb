class Ticket < ActiveRecord::Base
  attr_accessible :email, :ticket_time, :rate, :cell_number
  validate :ticket_time_is_valid, :email_is_valid

  def ticket_time_is_valid
    errors.add(:ticket_time, 'ticket time is not Right, please double check') if ticket_time >= Time.now
  end

  def email_is_valid
    errors.add(:email, 'email is not Right, please double check') unless email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
  end

end
