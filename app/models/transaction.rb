class Transaction < ActiveRecord::Base
  attr_accessible :buyer_email, :receipt_id, :status
#  validates :buyer_email, :presence => true, :email_format => true

#  validates_presence_of :buyer_email
end
