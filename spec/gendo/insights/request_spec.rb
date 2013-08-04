require_relative "../../../app/gendo/insights/request"

describe Insights::Request do
  describe "#applicable_to" do
    describe "#applicable_to" do
      it "returns all Insights applicable to the given source" do
        applicable   = double(applicable?: true).as_null_object
        unapplicable = double(applicable?: false).as_null_object

        allow(Insights::Request).to \
          receive(:all).
          and_return([applicable, unapplicable])

        applicable_to = Insights::Request.applicable_to(double(:request))

        expect(applicable_to).to eq([applicable])
      end
    end
  end
end
