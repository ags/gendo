require_relative "../../../../app/gendo/insights/request/base"
require_relative "../../../../app/gendo/insights/request/eager_load_associations"

describe Insights::Request::EagerLoadAssociations do
  describe "#applicable?" do
    let(:request) { double(:request, n_plus_one_queries: queries) }
    let(:insight) {
      Insights::Request::EagerLoadAssociations.new(request)
    }

    context "with associated n+1 queries" do
      let(:queries) { [double(:query)] }

      it "is true" do
        expect(insight.applicable?).to eq(true)
      end
    end

    context "without associated n+1 queries" do
      let(:queries) { [] }

      it "is false" do
        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
