class TicketMailer < ActionMailer::Base
  default :from => "notifications@example.com"
 
  def receipt_available_email(ticket)
    @ticket = ticket
    @url  = "http://example.com/login"
    mail(:to => "joshua.calloway@gmail.com", :subject => "A Meter receipt is available for your ticket")
  end
end
