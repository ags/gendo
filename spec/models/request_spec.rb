require "spec_helper"

describe Request do
  describe "#create_n_plus_one_query!" do
    it "creates an associated NPlusOneQuery" do
      request = Request.make!
      sql_event = SqlEvent.create!(request: request)

      query = request.create_n_plus_one_query!("posts", [sql_event])

      expect(query.request).to eq(request)
      expect(query.culprit_table_name).to eq("posts")
      expect(query.sql_events).to eq([sql_event])
    end
  end
end
