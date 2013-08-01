require "spec_helper"

describe Insights::Source do
  describe "#applicable_to" do
    it "returns all Insights applicable to the given source" do
      applicable   = double(applicable?: true).as_null_object
      unapplicable = double(applicable?: false).as_null_object

      allow(Insights::Source).to \
        receive(:all).
        and_return([applicable, unapplicable])

      applicable_to = Insights::Source.applicable_to(double(:transaction))

      expect(applicable_to).to eq([applicable])
    end
  end
end
