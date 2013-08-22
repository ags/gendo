module Sidekiq; module Worker; end; end

require "json"
require "support/factories/request_payload_hash"
require_relative "../../app/workers/process_request_payload_worker"

class App; end
class CreatesRequest; end
class IdentifyNPlusOneQueriesWorker; end

describe ProcessRequestPayloadWorker do
  describe "#process_for_app" do
    it "queues the worker with the given app id and payload" do
      payload = double(:payload)
      app = double(:app, id: 123)

      expect(ProcessRequestPayloadWorker).to \
        receive(:perform_async).
        with(app.id, payload)

      ProcessRequestPayloadWorker.process_for_app(app, payload)
    end
  end

  describe "#perform" do
    # sidekiq serializes data as JSON, so encode and decode our sample hash
    let(:payload) { JSON.load(create_request_payload_hash.to_json) }
    let(:app) { double(id: 123) }
    let(:request) { double(:request) }

    before do
      allow(App).to receive(:find).with(123).and_return(app)
      allow(CreatesRequest).to receive(:create!).and_return(request)
      allow(IdentifyNPlusOneQueriesWorker).to receive(:in_request)
    end

    it "creates a Request" do
      expect(CreatesRequest).to receive(:create!).with(app, payload).and_return(request)

      ProcessRequestPayloadWorker.new.perform(app.id, payload)
    end

    it "queues an IdentifyNPlusOneQueriesJob" do
      expect(IdentifyNPlusOneQueriesWorker).to receive(:in_request).with(request)

      ProcessRequestPayloadWorker.new.perform(app.id, payload)
    end
  end
end
