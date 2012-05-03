class RemovePurchasedAtFromReceipts < ActiveRecord::Migration
  def up
    remove_column :receipts, :purchased_at
      end

  def down
    add_column :receipts, :purchased_at, :string
  end
end
