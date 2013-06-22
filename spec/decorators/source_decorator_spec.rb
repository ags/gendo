require 'draper'
require './lib/gendo/transaction_stats'
require './app/decorators/source_decorator'

Draper::ViewContext.test_strategy :fast

class Source; end

describe SourceDecorator do
  subject(:decorated) { SourceDecorator.new(source) }

  describe "#latest_transactions" do
    let(:source) { stub(:source, transactions: stub(:transactions)) }

    it "returns transactions reverse sorted by created_at and decorated" do
      decorated_transactions = stub(:decorated_transactions)

      source.transactions.
        should_receive(:order).
        with("created_at DESC").
        and_return(stub(:ordered, decorate: decorated_transactions))

      expect(decorated.latest_transactions).to eq(decorated_transactions)
    end
  end

  describe "Gendo::TransactionStats" do
    let(:source) { stub(:source, transactions: stub(:transactions)) }

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
end
