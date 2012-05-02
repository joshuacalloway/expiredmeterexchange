class AddCellNumberToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :cell_number, :integer
  end
end
