require 'sidekiq'

class IdentifyCounterCacheableQuerySetsWorker
  include Sidekiq::Worker

  def self.in_request(request)
    perform_async(request.id)
  end

  def perform(request_id)
    request = Request.find(request_id)

    queries = IdentifiesCounterCacheableQuerySets.identify(request.sql_events)

    queries.each do |association_name, sql_events|
      request.create_counter_cacheable_query_set!(association_name, sql_events)
    end
  end
end
