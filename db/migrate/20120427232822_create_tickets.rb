class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :email

      t.timestamps
    end
  end
end
