class RemoveReceiptIdFromPaymentNotifications < ActiveRecord::Migration
  def up
    remove_column :payment_notifications, :receipt_id
      end

  def down
    add_column :payment_notifications, :receipt_id, :string
  end
end
