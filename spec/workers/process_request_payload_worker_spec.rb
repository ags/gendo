require "spec_helper"

# NOTE do I want to isolate here? don't feel compelled to integrate.
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
    let(:app) { App.make! }
    let(:perform!) {
      -> { ProcessRequestPayloadWorker.new.perform(app.id, payload) }
    }

    it "creates a Request" do
      expect(perform!).to change { app.requests.count }.by(+1)
    end

    it "queues an IdentifyNPlusOneQueriesJob" do
      expect(perform!).to change {
        IdentifyNPlusOneQueriesWorker.jobs.size
      }.by(1)
    end
  end
end
