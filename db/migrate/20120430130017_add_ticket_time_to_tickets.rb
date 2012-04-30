class AddTicketTimeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :ticket_time, :datetime
  end
end
