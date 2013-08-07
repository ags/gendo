require "sidekiq"
require_relative "../../app/workers/identify_n_plus_one_queries_worker"

class Request; end
class IdentifiesNPlusOneQueries; end

describe IdentifyNPlusOneQueriesWorker do
  describe "#from_request" do
    it "queues the worker with the given request id" do
      request = double(id: 123)

      expect(IdentifyNPlusOneQueriesWorker).to \
        receive(:perform_async).
        with(request.id)

      IdentifyNPlusOneQueriesWorker.in_request(request)
    end
  end

  describe "#perform" do
    it "persists n+1 queries identified in the given request" do
      sql_event = double(:sql_event)
      request = double(:request, id: 123, sql_events: [sql_event])

      expect(Request).to \
        receive(:find).
        with(request.id).
        and_return(request)

      expect(IdentifiesNPlusOneQueries).to \
        receive(:identify).
        with([sql_event]).
        and_return({"posts" => [sql_event]})

      expect(request).to \
        receive(:create_n_plus_one_query!).
        with("posts", [sql_event])

      worker = IdentifyNPlusOneQueriesWorker.new
      worker.perform(request.id)
    end
  end
end
