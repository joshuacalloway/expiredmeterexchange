class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :status, :txn_id, :transaction_id, :time
  serialize :params
  after_create :mark_receipt_as_purchased

  private
  def mark_receipt_as_purchased
    if status.casecmp "Completed"
      t = Transaction.find(transaction_id)
      t.update_attribute(:status, "paid at paypal")
    end
  end
end