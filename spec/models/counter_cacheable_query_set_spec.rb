require 'spec_helper'

describe CounterCacheableQuerySet do
  describe "#exists_for_requests?" do
    context "when any of the given requests has an associated CounterCacheableQuerySet" do
      it "is true" do
        requests = [Request.make!, CounterCacheableQuerySet.make!.request]

        expect(CounterCacheableQuerySet.exists_for_requests?(requests)).to eq(true)
      end
    end

    context "when none of the given requests has an associated CounterCacheableQuerySet" do
      it "is false" do
        requests = [Request.make!, Request.make!]

        expect(CounterCacheableQuerySet.exists_for_requests?(requests)).to eq(false)
      end
    end
  end

  describe "#duration" do
    it "is the sum of associated SQL events" do
      query = CounterCacheableQuerySet.make!
      query.sql_events << SqlEvent.make!(duration: 1)
      query.sql_events << SqlEvent.make!(duration: 2)

      expect(query.duration).to eq(3)
    end
  end
end
