class RenameTransactionsToRequests < ActiveRecord::Migration
  def change
    rename_table :transactions, :requests

    rename_column :mailer_events, :transaction_id, :request_id
    rename_column :n_plus_one_queries, :transaction_id, :request_id
    rename_column :sql_events, :transaction_id, :request_id
    rename_column :view_events, :transaction_id, :request_id
  end
end
