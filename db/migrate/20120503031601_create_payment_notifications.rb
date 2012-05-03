class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :receipt_id
      t.string :status
      t.integer :transaction_id

      t.timestamps
    end
  end
end
