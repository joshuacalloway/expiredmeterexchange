class Transaction < ActiveRecord::Base
  attr_accessible :buyer_email, :receipt_id, :status
  validates :buyer_email, :presence => true, :email_format => true

#  validates_presence_of :buyer_email
#  validate :buyer_email_is_valid


#  def buyer_email_is_valid
#    errors.add(:buyer_email, 'email is not right.  It should be in format of XXXX@gmail.com') unless buyer_email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
#  end

end
