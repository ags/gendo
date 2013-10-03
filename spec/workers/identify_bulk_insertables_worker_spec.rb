module Sidekiq; module Worker; end; end
require_relative "../../app/workers/identify_bulk_insertables_worker"

describe IdentifyBulkInsertablesWorker do
  describe "#in_request" do
    it "queues the worker with the given request id" do
      request = double(id: 123)

      expect(IdentifyBulkInsertablesWorker).to \
        receive(:perform_async).
        with(request.id)

      IdentifyBulkInsertablesWorker.in_request(request)
    end
  end

  describe "#perform" do
    it "persits bulk insertable queries identified in the request" do
      sql_event = double(:sql_event)
      request = instance_double("Request", id: 123, sql_events: [sql_event])

      expect(class_double("Request").as_stubbed_const).to \
        receive(:find).
        with(request.id).
        and_return(request)

      expect(class_double("IdentifiesBulkInsertables").as_stubbed_const).to \
        receive(:identify).
        with(request.sql_events).
        and_return({"posts" => {["title", "content"] => [sql_event]}})

      expect(request).to \
        receive(:create_bulk_insertable!).
        with("posts", ["title", "content"], [sql_event])

      IdentifyBulkInsertablesWorker.new.perform(request.id)
    end
  end
end
