require "spec_helper"

describe NPlusOneQuerySqlEvent do
  it "requires an NPlusOneQuerySqlEvent" do
    query = NPlusOneQuerySqlEvent.new

    expect(query.valid?).to be_false
    expect(query.errors.messages[:n_plus_one_query]).to eq(["can't be blank"])
  end

  it "requires an SqlEvent" do
    query = NPlusOneQuerySqlEvent.new

    expect(query.valid?).to be_false
    expect(query.errors.messages[:sql_event]).to eq(["can't be blank"])
  end
end
