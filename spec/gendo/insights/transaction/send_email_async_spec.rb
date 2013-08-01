require_relative "../../../../app/gendo/insights/transaction/base"
require_relative "../../../../app/gendo/insights/transaction/send_email_async"

describe Insights::Transaction::SendEmailAsync do
  describe "#applicable?" do
    let(:transaction) { double(:transaction, mailer_events: queries) }
    let(:insight) {
      Insights::Transaction::SendEmailAsync.new(transaction)
    }

    context "with associated mailer events" do
      let(:queries) { [double(:query)] }

      it "is true" do
        expect(insight.applicable?).to be_true
      end
    end

    context "without associated mailer events" do
      let(:queries) { [] }

      it "is false" do
        expect(insight.applicable?).to be_false
      end
    end
  end
end
