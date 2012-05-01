class Ticket < ActiveRecord::Base
  attr_accessible :email, :ticket_time, :rate, :cell_number
  validate :ticket_time_is_valid

  def ticket_time_is_valid
    errors.add(:ticket_time, 'ticket time is not Right, please double check') if ticket_time >= Time.now
  end

end
