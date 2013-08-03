class IdentifyNPlusOneQueriesWorker
  include Sidekiq::Worker

  def self.in_request(request)
    perform_async(request.id)
  end

  def perform(request_id)
    request = Request.find(request_id)

    queries = IdentifiesNPlusOneQueries.identify(request.sql_events)

    queries.each do |table_name, sql_events|
      request.create_n_plus_one_query!(table_name, sql_events)
    end
  end
end
