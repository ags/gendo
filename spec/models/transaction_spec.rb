require "spec_helper"

describe Transaction do
  it "requires a source" do
    transaction = Transaction.new

    expect(transaction.valid?).to be_false
    expect(transaction.errors.messages[:source]).to eq(["can't be blank"])
  end

  describe "#create_n_plus_one_query!" do
    it "creates an associated NPlusOneQuery" do
      transaction = Transaction.make!
      sql_event = SqlEvent.create!(transaction: transaction)

      query = transaction.create_n_plus_one_query!("posts", [sql_event])

      expect(query.transaction).to eq(transaction)
      expect(query.culprit_table_name).to eq("posts")
      expect(query.sql_events).to eq([sql_event])
    end
  end
end
