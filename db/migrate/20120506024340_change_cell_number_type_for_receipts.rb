class ChangeCellNumberTypeForReceipts < ActiveRecord::Migration
  def up
    change_column :receipts, :cell_number, :string
  end

  def down
    change_column :receipts, :cell_number, :integer
  end
end
