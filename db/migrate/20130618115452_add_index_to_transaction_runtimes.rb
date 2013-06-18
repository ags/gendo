class AddIndexToTransactionRuntimes < ActiveRecord::Migration
  def up
    add_index :transactions, :db_runtime
    add_index :transactions, :view_runtime
    add_index :transactions, :duration
  end

  def down
    remove_index :transactions, :db_runtime
    remove_index :transactions, :view_runtime
    remove_index :transactions, :duration
  end
end
