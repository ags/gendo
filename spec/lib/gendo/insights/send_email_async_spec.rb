require "spec_helper"

describe Gendo::Insights::SendEmailAsync do
  describe "#applicable_to_source?" do
    let(:transaction) { Transaction.make! }
    let(:applicable?) {
      Gendo::Insights::SendEmailAsync.applicable_to_source?(transaction.source)
    }

    context "when no associated transactions include MailerEvents" do
      it "is false" do
        expect(applicable?).to be_false
      end
    end

    context "when the source only has MailerEvents older than a day" do
      it "is false" do
        MailerEvent.make!(transaction: transaction, created_at: 2.days.ago)

        expect(applicable?).to be_false
      end
    end

    context "when the source has MailerEvents from the past day" do
      it "is true" do
        MailerEvent.make!(transaction: transaction)

        expect(applicable?).to be_true
      end
    end
  end
end
