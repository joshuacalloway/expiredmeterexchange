class AddPurchasedAtToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :purchased_at, :datetime
  end
end
