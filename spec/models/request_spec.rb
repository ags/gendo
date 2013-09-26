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

  describe "#create_bulk_insertable!" do
    it "creates an associated BulkInsertable" do
      request = Request.make!
      sql_event = SqlEvent.create!(request: request)

      bulk_insertable = request.create_bulk_insertable!(
        "posts",
        ["title", "content"],
        [sql_event]
      )

      expect(bulk_insertable.request).to eq(request)
      expect(bulk_insertable.culprit_table_name).to eq("posts")
      expect(bulk_insertable.column_names).to eq(["title", "content"])
      expect(bulk_insertable.sql_events).to eq([sql_event])
    end
  end
end
