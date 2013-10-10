require_relative "../../../../app/gendo/insights/request/base"
require_relative "../../../../app/gendo/insights/request/add_counter_cache_column"

describe Insights::Request::AddCounterCacheColumn do
  describe "#applicable?" do
    let(:request) {
      instance_double("Request", counter_cacheable_query_sets: queries)
    }
    subject(:insight) { described_class.new(request) }

    context "with associated counter cacheable query sets" do
      let(:queries) { [double(:query)] }

      it "is true" do
        expect(insight.applicable?).to eq(true)
      end
    end

    context "without associated counter cacheable query sets" do
      let(:queries) { [] }

      it "is false" do
        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
