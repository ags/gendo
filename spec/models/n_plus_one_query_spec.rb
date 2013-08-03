require "spec_helper"

describe NPlusOneQuery do
  it "requires a request" do
    query = NPlusOneQuery.new
    expect(query.valid?).to be_false
    expect(query.errors.messages[:request]).to eq(["can't be blank"])
  end

  it "requires a culprit_table_name" do
    query = NPlusOneQuery.new
    expect(query.valid?).to be_false
    expect(query.errors.messages[:culprit_table_name]).to eq(["can't be blank"])
  end

  describe "#duration" do
    it "is the sum of associated SQL events" do
      query = NPlusOneQuery.make!
      query.sql_events << SqlEvent.make!(duration: 1)
      query.sql_events << SqlEvent.make!(duration: 2)

      expect(query.duration).to eq(3)
    end
  end
end
