require_relative "../../../../app/gendo/insights/transaction/base"
require_relative "../../../../app/gendo/insights/transaction/eager_load_associations"

describe Insights::Transaction::EagerLoadAssociations do
  describe "#applicable?" do
    let(:transaction) { double(:transaction, n_plus_one_queries: queries) }
    let(:insight) {
      Insights::Transaction::EagerLoadAssociations.new(transaction)
    }

    context "with associated n+1 queries" do
      let(:queries) { [double(:query)] }

      it "is true" do
        expect(insight.applicable?).to be_true
      end
    end

    context "without associated n+1 queries" do
      let(:queries) { [] }

      it "is false" do
        expect(insight.applicable?).to be_false
      end
    end
  end
end
