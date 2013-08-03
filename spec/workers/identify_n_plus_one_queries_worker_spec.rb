require "spec_helper"

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
      request = Request.make!
      sql_event = SqlEvent.create!(request: request)

      expect(IdentifiesNPlusOneQueries).to \
        receive(:identify).
        with([sql_event]).
        and_return({"posts" => [sql_event]})

      worker = IdentifyNPlusOneQueriesWorker.new
      worker.perform(request.id)

      query = request.n_plus_one_queries.last
      expect(request.n_plus_one_queries).to eq([query])
      expect(query.culprit_table_name).to eq("posts")
      expect(query.sql_events).to eq([sql_event])
    end
  end
end
