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
end
