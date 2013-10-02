require "active_support/core_ext/module/delegation"
require_relative "../../../../app/gendo/insights/source/base"
require_relative "../../../../app/gendo/insights/source/eager_load_associations"

describe Insights::Source::EagerLoadAssociations do
  describe "#applicable?" do
    let(:source) { instance_double("Source") }
    let(:n_plus_one_query) { class_double("NPlusOneQuery").as_stubbed_const }
    let(:insight) { Insights::Source::EagerLoadAssociations.new(source) }
    let(:requests) { [double(:request)] }

    before do
      allow(source).to \
        receive(:latest_requests).
        with(limit: described_class::REQUESTS_CHECKED_COUNT).
        and_return(requests)
    end

    context "when an NPlusOneQuery exists for the latest associated requests" do
      it "is true" do
        allow(n_plus_one_query).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(true)

        expect(insight.applicable?).to eq(true)
      end
    end

    context "when no NPlusOneQuery exists for the latest associated requests" do
      it "is false" do
        allow(n_plus_one_query).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(false)

        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
