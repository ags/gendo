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

  describe "#perform" do
    it "persists n+1 queries identified in the given transaction" do
      transaction = Transaction.make!
      sql_event = SqlEvent.create!(transaction: transaction)

      expect(IdentifiesNPlusOneQueries).to \
        receive(:identify).
        with([sql_event]).
        and_return({"posts" => [sql_event]})

      worker = IdentifyNPlusOneQueriesWorker.new
      worker.perform(transaction.id)

      query = transaction.n_plus_one_queries.last
      expect(transaction.n_plus_one_queries).to eq([query])
      expect(query.culprit_table_name).to eq("posts")
      expect(query.sql_events).to eq([sql_event])
    end
  end
end
