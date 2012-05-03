class AddTimeToPaymentNotifications < ActiveRecord::Migration
  def change
    add_column :payment_notifications, :time, :datetime
  end
end
