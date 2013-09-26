require_relative "../../../../app/gendo/insights/source/base"
require_relative "../../../../app/gendo/insights/source/bulk_insert_data"

class BulkInsertable; end

describe Insights::Source::BulkInsertData do
  describe "#applicable?" do
    let(:source) { double(:source) }
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
        allow(BulkInsertable).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(true)

        expect(insight.applicable?).to be_true
      end
    end

    context "when no NPlusOneQuery exists for the latest associated requests" do
      it "is false" do
        allow(BulkInsertable).to \
          receive(:exists_for_requests?).
          with(requests).
          and_return(false)

        expect(insight.applicable?).to be_false
      end
    end
  end
end
