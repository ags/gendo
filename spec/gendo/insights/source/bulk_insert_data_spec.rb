require "active_support/core_ext/module/delegation"
require_relative "../../../../app/gendo/insights/source/base"
require_relative "../../../../app/gendo/insights/source/bulk_insert_data"

describe Insights::Source::BulkInsertData do
  describe "#applicable?" do
    let(:source) { instance_double("Source") }
    let(:bulk_insertable) { class_double("BulkInsertable").as_stubbed_const }
    let(:insight) { Insights::Source::BulkInsertData.new(source) }
    let(:requests) { [double(:request)] }

    before do
      allow(source).to \
        receive(:latest_requests).
        with(limit: described_class::REQUESTS_CHECKED_COUNT).
        and_return(requests)
    end

    context "when a BulkInsertable exists for the latest associated requests" do
      it "is true" do
        allow(bulk_insertable).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(true)

        expect(insight.applicable?).to eq(true)
      end
    end

    context "when no NPlusOneQuery exists for the latest associated requests" do
      it "is false" do
        allow(bulk_insertable).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(false)

        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
