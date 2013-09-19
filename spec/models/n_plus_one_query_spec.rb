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
end
