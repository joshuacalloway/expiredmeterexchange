class ChangeCellNumberTypeForTickets < ActiveRecord::Migration
  def up
    change_column :tickets, :cell_number, :string
  end

  def down
    change_column :tickets, :cell_number, :integer
  end
end
