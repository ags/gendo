require "active_support/core_ext/module/delegation"
require_relative "../../../../app/gendo/insights/source/base"
require_relative "../../../../app/gendo/insights/source/add_counter_cache_column"

describe Insights::Source::AddCounterCacheColumn do
  let(:source) { instance_double("Source") }
  let(:insight) { described_class.new(source) }

  describe "#latest_counter_cacheable" do
    it "delegates to the source" do
      latest = double(:latest_counter_cacheable_query_set)

      expect(source).to \
        receive(:latest_counter_cacheable_query_set).
        and_return(latest)

      expect(insight.latest_counter_cacheable_query_set).to eq(latest)
    end
  end

  describe "#applicable?" do
    let(:counter_cacheable_query_set) {
      class_double("CounterCacheableQuerySet").as_stubbed_const
    }
    let(:requests) { double(:latest_requests) }

    before do
      allow(source).to \
        receive(:latest_requests).
        with(limit: described_class::REQUESTS_CHECKED_COUNT).
        and_return(requests)
    end

    context "when a CounterCacheableQuerySet exists for the latest associated requests" do
      it "is true" do
        allow(counter_cacheable_query_set).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(true)

        expect(insight.applicable?).to eq(true)
      end
    end

    context "when no CounterCacheableQuerySet exists for the latest associated requests" do
      it "is false" do
        allow(counter_cacheable_query_set).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(false)

        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
