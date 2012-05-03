class AddTxnIdToPaymentNotifications < ActiveRecord::Migration
  def change
    add_column :payment_notifications, :txn_id, :string
  end
end
