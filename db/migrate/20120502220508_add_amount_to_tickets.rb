class AddAmountToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :amount, :decimal
  end
end
