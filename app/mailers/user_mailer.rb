class UserMailer < ActionMailer::Base
#  default from: "from@example.com"
  default :from => "notifications@example.com"
 
  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => "joshua.calloway@gmail.com", :subject => "Welcome to My Awesome Site")
  end

  def receiptavailable_email(receipt)
    
    @receipt = receipt
    @url  = "http://example.com/login"
    @tickets = Ticket.select("distinct tickets.*").where('tickets.ticket_time between ? and ? and tickets.rate <= ?', @receipt.purchased_time, @receipt.expiration_time, @receipt.rate)
    @tickets.each { |ticket|
      @ticket = ticket
      mail(:to => "joshua.calloway@gmail.com", :subject => "A Meter receipt is available for your parking ticket on #{ticket.ticket_time.to_s(:long)}").deliver
    }
  end
end
