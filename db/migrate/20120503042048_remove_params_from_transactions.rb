class RemoveParamsFromTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :params
      end

  def down
    add_column :transactions, :params, :string
  end
end
