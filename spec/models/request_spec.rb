require "spec_helper"

describe Request do
  it "requires a source" do
    request = Request.new

    expect(request.valid?).to be_false
    expect(request.errors.messages[:source]).to eq(["can't be blank"])
  end

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
