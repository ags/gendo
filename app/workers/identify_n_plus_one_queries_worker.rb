class IdentifyNPlusOneQueriesWorker
  include Sidekiq::Worker

  def self.in_transaction(transaction)
    perform_async(transaction.id)
  end
end
