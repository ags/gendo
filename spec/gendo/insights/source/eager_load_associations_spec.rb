require "spec_helper"

describe Insights::Source::EagerLoadAssociations do
  describe "#applicable?" do
    let(:source) { Source.make! }
    let(:insight) { Insights::Source::EagerLoadAssociations.new(source) }

    context "when one or more of the 10 most recent associated transactions has an n+1 query" do
      it "is true" do
        transactions = 10.times.map { Transaction.create!(source: source) }
        NPlusOneQuery.make!(transaction: transactions[0])

        expect(insight.applicable?).to be_true
      end
    end

    context "when none of the 10 most recent associated transactions has an n+1 query" do
      it "is false" do
        transactions = 11.times.map { Transaction.create!(source: source) }
        NPlusOneQuery.make!(transaction: transactions[0])

        expect(insight.applicable?).to be_false
      end
    end

    context "when no associated transactions include NPlusOneQueries" do
      it "is false" do
        Transaction.make!(source: source)

        expect(insight.applicable?).to be_false
      end
    end
  end

  describe "#latest_n_plus_one_query" do
    it "returns the most recently detected associated NPlusOneQuery" do
      transaction = Transaction.make!
      insight = Insights::Source::EagerLoadAssociations.new(transaction.source)

      a = NPlusOneQuery.make!(transaction: transaction, created_at: 3.days.ago)
      b = NPlusOneQuery.make!(transaction: transaction, created_at: 1.days.ago)
      c = NPlusOneQuery.make!(transaction: transaction, created_at: 2.days.ago)

      expect(insight.latest_n_plus_one_query).to eq(b)
    end
  end
end
