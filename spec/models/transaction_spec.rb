require 'spec_helper'

describe Transaction do
  describe "#recent" do
    it "returns a requested number of the most recent Transactions" do
      a = Transaction.make!
      b = Transaction.make!
      c = Transaction.make!

      expect(Transaction.recent(2)).to eq([c, b])
    end
  end
end
