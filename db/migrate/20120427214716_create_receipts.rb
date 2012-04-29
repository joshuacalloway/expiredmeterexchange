class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :email
      t.decimal :rate
      t.date :purchased_date
      t.timestamp :purchased_time
      t.timestamp :expiration_time

      t.timestamps
    end
  end
end
