require "spec_helper"

describe Gendo::Insights::EagerLoadAssociations do
  let(:transaction) { Transaction.make! }
  let(:insight) {
    Gendo::Insights::EagerLoadAssociations.new(transaction.source)
  }

  describe "#applicable?" do
    context "when no associated transactions include NPlusOneQueries" do
      it "is false" do
        expect(insight.applicable?).to be_false
      end
    end

    context "when the source only has NPlusOneQueries older than a day" do
      it "is false" do
        NPlusOneQuery.make!(transaction: transaction, created_at: 2.days.ago)

        expect(insight.applicable?).to be_false
      end
    end

    context "when there are NPlusOneQueries in the past day" do
      it "is true" do
        NPlusOneQuery.make!(transaction: transaction)

        expect(insight.applicable?).to be_true
      end
    end
  end
end
