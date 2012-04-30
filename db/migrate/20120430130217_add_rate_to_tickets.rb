class AddRateToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :rate, :decimal
  end
end
