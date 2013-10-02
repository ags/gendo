require "spec_helper"

describe BulkInsertable do
  describe "#exists_for_requests?" do
    context "when any of the given requests has an associated BulkInsertable" do
      it "is true" do
        requests = [Request.make!, BulkInsertable.make!.request]

        expect(BulkInsertable.exists_for_requests?(requests)).to eq(true)
      end
    end

    context "when none of the given requests has an associated BulkInsertable" do
      it "is false" do
        requests = [Request.make!, Request.make!]

        expect(BulkInsertable.exists_for_requests?(requests)).to eq(false)
      end
    end
  end
end
