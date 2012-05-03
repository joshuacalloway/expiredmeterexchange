class Receipt < ActiveRecord::Base
  has_many :payment_notifications
  attr_accessible :email, :expiration_time, :purchased_time, :rate, :total_paid, :cell_number, :purchased_at
  validate :purchased_time_is_valid, :email_is_valid, :expiration_time_is_valid, :total_paid_is_valid

  def paypal_url(transaction_id, return_url, payment_notification_url)
    values = {
      :business => 'joshua_1335998954_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :notify_url => payment_notification_url,
      :invoice => transaction_id
    }
    values["amount_1"] = 1.0
    values["item_name_1"] = "ContactInfoForMeterReceipt"
    values["item_number_1"] = id
    values["quantity_1"] = 1
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end


  def expiration_time_is_valid
    errors.add(:expiration_time, 'expiration time is not Right, please double check') if expiration_time <= purchased_time
  end

  def purchased_time_is_valid
    errors.add(:purchased_time, 'purchased time is not Right, please double check') if purchased_time > Time.now
  end

  def total_paid_reasonable
    expected_paid = (expiration_time - purchased_time ) / 3600 * rate
    expected_paid_range = expected_paid * 0.2
    total_paid < expected_paid + expected_paid_range && total_paid > expected_paid - expected_paid_range
  end

  def total_paid_is_valid
    expected_paid = (expiration_time - purchased_time ) / 3600 * rate
    expected_paid_range = expected_paid * 0.2

    errors.add(:total_paid, 'total paid is not right.  Please double check ' + expected_paid.to_s) unless total_paid_reasonable
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
