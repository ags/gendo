require "spec_helper"

describe IdentifyNPlusOneQueriesWorker do
  describe "#from_transaction" do
    it "queues the worker with the given transaction id" do
      transaction = double(id: 123)

      expect(IdentifyNPlusOneQueriesWorker).to \
        receive(:perform_async).
        with(transaction.id)

      IdentifyNPlusOneQueriesWorker.in_transaction(transaction)
    end
  end
end
