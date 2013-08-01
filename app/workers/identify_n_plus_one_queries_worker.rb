class IdentifyNPlusOneQueriesWorker
  include Sidekiq::Worker

  def self.in_transaction(transaction)
    perform_async(transaction.id)
  end

  def perform(transaction_id)
    transaction = Transaction.find(transaction_id)

    queries = IdentifiesNPlusOneQueries.identify(transaction.sql_events)

    queries.each do |table_name, sql_events|
      transaction.create_n_plus_one_query!(table_name, sql_events)
    end
  end
end
