require 'spec_helper'

describe Transaction do
  describe "#source" do
    it "is a Source for the associated App named controller#action" do
      transaction = Transaction.make!(controller: "PostsController", action: "new")
      expect(transaction.source).to \
        eq(Source.new(transaction.app, "PostsController#new"))
    end
  end

  describe "#recent" do
    it "returns a requested number of the most recent Transactions" do
      a = Transaction.make!
      b = Transaction.make!
      c = Transaction.make!

      expect(Transaction.recent(2)).to eq([c, b])
    end
  end
end
