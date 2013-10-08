module Sidekiq; module Worker; end; end
require_relative '../../app/workers/identify_counter_cacheable_query_sets_worker'

describe IdentifyCounterCacheableQuerySetsWorker do
  describe "#in_request" do
    it "queues the worker with the given request id" do
      request = double(:request, id: 123)

      expect(described_class).to \
        receive(:perform_async).
        with(request.id)

      described_class.in_request(request)
    end
  end

  describe "#perform" do
    let(:identifier) { 
      class_double("IdentifiesCounterCacheableQuerySets").as_stubbed_const
    }

    it "persists counter cacheable query sets identified in the request" do
      sql_events = double(:sql_events)
      request = instance_double("Request", id: 123, sql_events: sql_events)

      expect(class_double("Request").as_stubbed_const).to \
        receive(:find).
        with(request.id).
        and_return(request)

      expect(identifier).to \
        receive(:identify).
        with(sql_events).
        and_return({"posts" => sql_events})

      expect(request).to \
        receive(:create_counter_cacheable_query_set!).
        with("posts", sql_events)

      described_class.new.perform(request.id)
    end
  end
end
