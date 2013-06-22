require 'draper'
require 'timecop'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/transaction_decorator'

Draper::ViewContext.test_strategy :fast

class Transaction; end

describe TransactionDecorator do
  it_behaves_like "an object with decorated event timestamps"

  subject(:decorated) { TransactionDecorator.new(transaction) }

  describe "#events" do
    let(:a) { stub(:a, started_at: 1.minute.ago).as_null_object }
    let(:b) { stub(:b, started_at: 2.minutes.ago).as_null_object }
    let(:c) { stub(:c, started_at: 30.seconds.ago).as_null_object }
    let(:transaction) { stub(sql_events: [a, c], view_events: [b]) }

    it "combines sql and view events ordered by started_at" do
      expect(decorated.events).to eq([b, a, c])
    end
  end

  describe "#db_runtime" do
    let(:transaction) { stub(db_runtime: 1.234) }

    it "returns the db runtime and millsecond time unit" do
      expect(decorated.db_runtime).to eq("1.234 ms")
    end
  end

  describe "#view_runtime" do
    let(:transaction) { stub(view_runtime: 1.234) }

    it "returns the view runtime and millsecond time unit" do
      expect(decorated.view_runtime).to eq("1.234 ms")
    end
  end

  describe "#duration" do
    let(:transaction) { stub(duration: 1.234) }

    it "returns the view runtime and millsecond time unit" do
      expect(decorated.duration).to eq("1.234 ms")
    end
  end

  describe "#collected_timings?" do

    context "with a db_runtime and view_runtime" do
      let(:transaction) { stub(:transaction, db_runtime: 1, view_runtime: 2) }

      it "is true" do
        expect(decorated.collected_timings?).to be_true
      end
    end

    context "with just a db_runtime" do
      let(:transaction) { stub(:transaction, db_runtime: 1, view_runtime: nil) }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end

    context "with just a view_runtime" do
      let(:transaction) { stub(:transaction, db_runtime: nil, view_runtime: 2) }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end

    context "with neither db_runtime nor view_runtime" do
      let(:transaction) {
        stub(:transaction, db_runtime: nil, view_runtime: nil)
      }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end
  end

  describe "#time_breakdown_graph_data" do
    let(:transaction) { stub(:transaction, db_runtime: 1, view_runtime: 2) }

    it "returns db and view runtimes formatted for morris.js" do
      expect(decorated.time_breakdown_graph_data).to eq([
        {label: "Database", value: 1},
        {label: "Views", value: 2}
      ])
    end
  end

  describe "#fuzzy_timestamp" do
    it "is a fuzzy timestamp of created_at" do
      Timecop.freeze(Time.now) do
        transaction = stub(:transaction, created_at: 30.minutes.ago)
        decorated = TransactionDecorator.new(transaction)
        expect(decorated.fuzzy_timestamp).to eq("30 minutes ago")
      end
    end
  end
end
