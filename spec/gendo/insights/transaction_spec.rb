require "spec_helper"

describe Insights::Transaction do
  describe "#applicable_to" do
    describe "#applicable_to" do
      it "returns all Insights applicable to the given source" do
        applicable   = double(applicable?: true).as_null_object
        unapplicable = double(applicable?: false).as_null_object  

        allow(Insights::Transaction).to \
          receive(:all).
          and_return([applicable, unapplicable])

        applicable_to = Insights::Transaction.applicable_to(double(:transaction))

        expect(applicable_to).to eq([applicable])
      end
    end
  end
end
