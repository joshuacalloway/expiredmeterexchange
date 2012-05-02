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

  def mailto_link
    "mailto:"+email + "?Subject=I want to buy your Parking Meter Receipt that you posted on http://pmrexchange.com&Body=I'd like to pay suggested value of $5.00 for your receipt.%0AThe receipt is for " + purchased_time.to_s + " at #{rate} rate%0APlease provide me a paypal or another easy method for me to get this money to you.%0AYou can then send the receipt to my mailing address at One XXX street, chicago IL 6XXXX.%0A%0AThank you very much"
  end

  def self.search(search)
    self.where("purchased_time <= :purchased_time_end and expiration_time >= :expiration_time_start and rate >= :rate", search.conditions)
  end

end
