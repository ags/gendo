require_relative "../../../../app/gendo/insights/request/base"
require_relative "../../../../app/gendo/insights/request/bulk_insert_data"

describe Insights::Request::BulkInsertData do
  describe "#applicable?" do
    let(:request) { instance_double("Request", bulk_insertables: bulk_insertables) }
    let(:insight) { Insights::Request::BulkInsertData.new(request) }

    context "with associated bulk insertables" do
      let(:bulk_insertables) { [double(:bulk_insertable)] }

      it "is true" do
        expect(insight.applicable?).to eq(true)
      end
    end

    context "without associated bulk insertables" do
      let(:bulk_insertables) { [] }

      it "is false" do
        insight = Insights::Request::BulkInsertData.new(request)

        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
