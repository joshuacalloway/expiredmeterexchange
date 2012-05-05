class Receipt < ActiveRecord::Base
  has_many :payment_notifications
  has_attached_file :image, :url => "/assets/receipts/:id/:basename.:extension", :path => ":rails_root/public/assets/receipts/:id/:basename.:extension"

  attr_accessible :email, :expiration_time, :purchased_time, :rate, :total_paid, :cell_number, :image
  validate :purchased_time_is_valid, :expiration_time_is_valid, :total_paid_is_valid
  validates :email, :presence => true, :email_format => true
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

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
    errors.add(:expiration_time, 'expiration time is not right, It should be greater then purchase time') if expiration_time <= purchased_time
    errors.add(:expiration_time, 'expiration time is not right, Total time paid should be within 24 hours') if !is_total_time_reasonable
  end

  def purchased_time_is_valid
    errors.add(:purchased_time, 'purchased time is not right.  It should be in past') if purchased_time > Time.now
    errors.add(:purchased_time, 'purchased time is not right.  It should be within last 3 months') if !is_purchased_time_reasonable
  end

  def is_purchased_time_reasonable
    purchased_time > Time.now.advance(:days => -90)
  end

  def is_total_time_reasonable
    (expiration_time - purchased_time) / 3600 < 24  # 24 hours
  end

  def total_paid_reasonable
    expected_paid = (expiration_time - purchased_time ) / 3600 * rate
    expected_paid_range = expected_paid * 0.2
    total_paid < expected_paid + expected_paid_range && total_paid > expected_paid - expected_paid_range
  end

  def total_paid_is_valid
    expected_paid = (expiration_time - purchased_time ) / 3600 * rate
    expected_paid_range = expected_paid * 0.2

    errors.add(:total_paid, 'total paid is not right.  Should be closer to $' + expected_paid.to_s) unless total_paid_reasonable
  end

#  def email_is_valid
#    errors.add(:email, 'email is not right.  It should be in format of XXXX@gmail.com') unless email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
#  end

  def mailto_link
    "mailto:"+email + "?Subject=I want to buy your Parking Meter Receipt that you posted on http://pmrexchange.com&Body=I'd like to pay suggested value of $5.00 for your receipt.%0AThe receipt is for " + purchased_time.to_s + " at #{rate} rate%0APlease provide me a paypal or another easy method for me to get this money to you.%0AYou can then send the receipt to my mailing address at One XXX street, chicago IL 6XXXX.%0A%0AThank you very much"
  end

  def self.search(search)
    self.where("purchased_time <= :purchased_time_end and expiration_time >= :expiration_time_start and rate >= :rate", search.conditions)
  end

end
