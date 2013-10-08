module Sidekiq; module Worker; end; end
require_relative "../../app/workers/process_request_payload_worker"

describe ProcessRequestPayloadWorker do
  let(:payload) { double(:request_payload) }
  let(:app) { double(id: 123) }

  describe "#process_for_app" do
    it "queues the worker with the given app id and payload" do
      expect(ProcessRequestPayloadWorker).to \
        receive(:perform_async).
        with(app.id, payload)

      ProcessRequestPayloadWorker.process_for_app(app, payload)
    end
  end

  describe "#perform" do
    let(:app_class) { class_double("App").as_stubbed_const }
    let(:creates_request) { class_double("CreatesRequest").as_stubbed_const }
    let(:n_plus_one_identifier) {
      class_double("IdentifyNPlusOneQueriesWorker").as_stubbed_const
    }
    let(:bulk_insertables_identifier) {
      class_double("IdentifyBulkInsertablesWorker").as_stubbed_const
    }
    let(:counter_cacheable_query_sets_identifer) {
      class_double("IdentifyCounterCacheableQuerySetsWorker").as_stubbed_const
    }

    let(:request) { double(:request) }

    subject(:perform!) { described_class.new.perform(app.id, payload) }

    before do
      allow(app_class).to receive(:find).with(123).and_return(app)
      allow(creates_request).to receive(:create!).and_return(request)
      allow(n_plus_one_identifier).to receive(:in_request)
      allow(bulk_insertables_identifier).to receive(:in_request)
      allow(counter_cacheable_query_sets_identifer).to receive(:in_request)
    end

    it "creates a Request" do
      expect(creates_request).to \
        receive(:create!).
        with(app, payload).
        and_return(request)

      perform!
    end

    it "queues an IdentifyNPlusOneQueriesWorker" do
      expect(n_plus_one_identifier).to \
        receive(:in_request).
        with(request)

      perform!
    end

    it "queues an IdentifyBulkInsertablesWorker" do
      expect(bulk_insertables_identifier).to \
        receive(:in_request).
        with(request)

      perform!
    end

    it "queues an IdentifyCounterCacheableQuerySetsWorker" do
      expect(counter_cacheable_query_sets_identifer).to \
        receive(:in_request).
        with(request)

      perform!
    end
  end
end
