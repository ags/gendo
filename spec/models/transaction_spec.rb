require "spec_helper"

describe Transaction do
  it "requires a source" do
    transaction = Transaction.new

    expect(transaction.valid?).to be_false
    expect(transaction.errors.messages[:source]).to eq(["can't be blank"])
  end
end
