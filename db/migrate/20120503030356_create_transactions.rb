class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :receipt_id
      t.string :buyer_email
      t.text :params
      t.string :status

      t.timestamps
    end
  end
end
