class ProcessRequestPayloadWorker
  include Sidekiq::Worker

  def self.process_for_app(app, request_payload)
    perform_async(app.id, request_payload)
  end

  def perform(app_id, request_payload)
    app = App.find(app_id)

    request = CreatesRequest.create!(app, request_payload)

    IdentifyNPlusOneQueriesWorker.in_request(request)

    IdentifyBulkInsertablesWorker.in_request(request)

    IdentifyCounterCacheableQuerySetsWorker.in_request(request)
  end
end
