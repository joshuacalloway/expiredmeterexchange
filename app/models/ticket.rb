class Ticket < ActiveRecord::Base
  attr_accessible :email, :ticket_time, :rate
end
