require 'draper'
require './lib/gendo/insights'
require './lib/gendo/transaction_stats'
require './app/decorators/source_decorator'

Draper::ViewContext.test_strategy :fast

class Source; end

describe SourceDecorator do
  subject(:decorated) { SourceDecorator.new(source) }

  describe "#latest_transactions" do
    let(:source) { double(:source, transactions: double(:transactions)) }

    it "returns transactions reverse sorted by created_at and decorated" do
      decorated_transactions = double(:decorated_transactions)

      expect(source).to \
        receive(:latest_transactions).
        and_return(double(:latest, decorate: decorated_transactions))

      expect(decorated.latest_transactions).to eq(decorated_transactions)
    end
  end

  describe "Gendo::TransactionStats" do
    let(:source) { double(:source, transactions: double(:transactions)) }

    describe "#db" do
      it "is Gendo::TransactionStats for db_runtime" do
        expect(decorated.db).to \
          eq(Gendo::TransactionStats.new(source.transactions, :db_runtime))
      end
    end

    describe "#view" do
      it "is Gendo::TransactionStats for view_runtime" do
        expect(decorated.view).to \
          eq(Gendo::TransactionStats.new(source.transactions, :view_runtime))
      end
    end

    describe "#duration" do
      it "is Gendo::TransactionStats for view_runtime" do
        expect(decorated.duration).to \
          eq(Gendo::TransactionStats.new(source.transactions, :duration))
      end
    end
  end

  describe "#insights" do
    let(:source) { double(:source) }

    class FooIns; end

    it "is a list of applicable insight classes" do
      Gendo::Insights.stub(:applicable_to_source) { [FooIns] }

      expect(decorated.insights).to eq([FooIns])
    end
  end
end
