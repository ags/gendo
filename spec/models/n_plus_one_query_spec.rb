require "spec_helper"

describe NPlusOneQuery do
  describe "#duration" do
    it "is the sum of associated SQL events" do
      query = NPlusOneQuery.make!
      query.sql_events << SqlEvent.make!(duration: 1)
      query.sql_events << SqlEvent.make!(duration: 2)

      expect(query.duration).to eq(3)
    end
  end

  describe "#exists_for_requests?" do
    context "when one of the requests has an associated NPlusOneQuery" do
      it "is true" do
        requests = [Request.make!, NPlusOneQuery.make!.request]

        expect(NPlusOneQuery.exists_for_requests?(requests)).to eq(true)
      end
    end

    context "when none of the requests has an associated NPlusOneQuery" do
      it "is false" do
        requests = [Request.make!, Request.make!]

        expect(NPlusOneQuery.exists_for_requests?(requests)).to eq(false)
      end
    end
  end
end
