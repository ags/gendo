class ProcessTransactionPayloadWorker
  include Sidekiq::Worker

  def self.process_for_app(app, transaction_payload)
    perform_async(app.id, transaction_payload)
  end

  def perform(app_id, transaction_payload)
    app = App.find(app_id)

    transaction = CreatesTransaction.create!(app, transaction_payload)

    IdentifyNPlusOneQueriesWorker.in_transaction(transaction)
  end
end
