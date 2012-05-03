class Transaction < ActiveRecord::Base
  attr_accessible :buyer_email, :receipt_id, :status
end
