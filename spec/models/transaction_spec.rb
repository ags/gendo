require 'spec_helper'

describe Transaction do
  describe "#events" do
    it "combines sql and view events ordered by started_at" do
      transaction = Transaction.create!(controller: 'a', action: 'b')
      a = SqlEvent.create!(started_at: 1.minute.ago,
                           transaction: transaction)
      b = ViewEvent.create!(started_at: 2.minutes.ago,
                           transaction: transaction,
                           identifier: 'foo')
      c = SqlEvent.create!(started_at: 30.seconds.ago,
                           transaction: transaction)

      expect(transaction.events).to eq([b, a, c])
    end
  end
end
