class AddTotalPaidToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :total_paid, :decimal
  end
end
