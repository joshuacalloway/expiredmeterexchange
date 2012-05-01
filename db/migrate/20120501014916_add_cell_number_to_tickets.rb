class AddCellNumberToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :cell_number, :integer
  end
end
