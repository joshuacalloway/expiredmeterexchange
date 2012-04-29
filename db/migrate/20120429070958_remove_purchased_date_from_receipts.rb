class RemovePurchasedDateFromReceipts < ActiveRecord::Migration
  def up
    remove_column :receipts, :purchased_date
      end

  def down
    add_column :receipts, :purchased_date, :date
  end
end
