module Sidekiq; module Worker; end; end
require_relative "../../app/workers/identify_n_plus_one_queries_worker"

describe IdentifyNPlusOneQueriesWorker do
  describe "#in_request" do
    it "queues the worker with the given request id" do
      request = double(:request, id: 123)

      expect(IdentifyNPlusOneQueriesWorker).to \
        receive(:perform_async).
        with(request.id)

      IdentifyNPlusOneQueriesWorker.in_request(request)
    end
  end

  describe "#perform" do
    it "persists n+1 queries identified in the given request" do
      sql_events = [double(:sql_event)]
      request = instance_double("Request", id: 123, sql_events: sql_events)

      expect(class_double("Request").as_stubbed_const).to \
        receive(:find).
        with(request.id).
        and_return(request)

      expect(class_double("IdentifiesNPlusOneQueries").as_stubbed_const).to \
        receive(:identify).
        with(sql_events).
        and_return({"posts" => sql_events})

      expect(request).to \
        receive(:create_n_plus_one_query!).
        with("posts", sql_events)

      worker = IdentifyNPlusOneQueriesWorker.new
      worker.perform(request.id)
    end
  end
end
