require "spec_helper"

describe Insights::Source::SendEmailAsync do
  describe "#applicable?" do
    let(:request) { Request.make! }
    let(:insight) {
      Insights::Source::SendEmailAsync.new(request.source)
    }

    context "when no associated requests include MailerEvents" do
      it "is false" do
        expect(insight.applicable?).to be_false
      end
    end

    context "when the source only has MailerEvents older than a day" do
      it "is false" do
        MailerEvent.make!(request: request, created_at: 2.days.ago)

        expect(insight.applicable?).to be_false
      end
    end

    context "when the source has MailerEvents from the past day" do
      it "is true" do
        MailerEvent.make!(request: request)

        expect(insight.applicable?).to be_true
      end
    end
  end
end
