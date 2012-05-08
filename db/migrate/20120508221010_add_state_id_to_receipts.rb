class AddStateIdToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :state_id, :integer
  end
end
