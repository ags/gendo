require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/transaction_decorator'

Draper::ViewContext.test_strategy :fast

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
end
