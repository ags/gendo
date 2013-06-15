require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/transaction_decorator'

Draper::ViewContext.test_strategy :fast

class Transaction; end

describe TransactionDecorator do
  it_behaves_like "an object with decorated event timestamps"

  describe "#events" do
    it "combines sql and view events ordered by started_at" do
      a = stub(:a, started_at: 1.minute.ago).as_null_object
      b = stub(:b, started_at: 2.minutes.ago).as_null_object
      c = stub(:c, started_at: 30.seconds.ago).as_null_object

      transaction = stub(sql_events: [a, c], view_events: [b])
      decorated = TransactionDecorator.new(transaction)

      expect(decorated.events).to eq([b, a, c])
    end
  end

  describe "#source" do
    it "is the controller#action" do
      transaction = stub(controller: "PostsController", action: "new")
      decorated = TransactionDecorator.new(transaction)

      expect(decorated.source).to eq("PostsController#new")
    end
  end

  describe "#db_runtime" do
    it "returns the db runtime and millsecond time unit" do
      transaction = stub(db_runtime: 1.234)
      decorated = TransactionDecorator.new(transaction)

      expect(decorated.db_runtime).to eq("1.234 ms")
    end
  end
end
