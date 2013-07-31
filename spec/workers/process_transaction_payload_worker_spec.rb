require "spec_helper"
require "sidekiq/testing"

describe ProcessTransactionPayloadWorker do
  describe "#process_for_app" do
    it "queues the worker with the given app id and payload" do
      payload = double(:payload)
      app = double(:app, id: 123)

      expect(ProcessTransactionPayloadWorker).to \
        receive(:perform_async).
        with(app.id, payload)

      ProcessTransactionPayloadWorker.process_for_app(app, payload)
    end
  end

  describe "#perform" do
    # sidekiq serializes data as JSON, so encode and decode our sample hash
    let(:payload) { JSON.load(transaction_payload_hash.to_json) }
    let(:app) { App.make! }
    let(:perform!) {
      -> { ProcessTransactionPayloadWorker.new.perform(app.id, payload) }
    }

    it "creates a Transaction" do
      expect(perform!).to change { app.transactions.count }.by(+1)
    end

    it "queues an IdentifyNPlusOneQueriesJob" do
      expect(perform!).to change {
        IdentifyNPlusOneQueriesWorker.jobs.size
      }.by(1)
    end
  end
end
