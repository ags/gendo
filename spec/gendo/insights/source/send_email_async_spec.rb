require "active_support/core_ext/module/delegation"
require "active_support/time"
require_relative "../../../../app/gendo/insights/source/base"
require_relative "../../../../app/gendo/insights/source/send_email_async"

describe Insights::Source::SendEmailAsync do
  let(:source) { instance_double("Source") }
  let(:insight) { described_class.new(source) }

  describe "#applicable?" do
    before do
      allow(source).to \
        receive(:mailer_events_created_after).
        and_return(mailer_events)
    end

    context "when the source only has MailerEvents older than a day" do
      let(:mailer_events) { [] }

      it "is false" do
        expect(insight.applicable?).to eq(false)
      end
    end

    context "when the source has MailerEvents from the past day" do
      let(:mailer_events) { [double(:mailer_event)] }

      it "is true" do
        expect(insight.applicable?).to eq(true)
      end
    end
  end

  describe "#latest_mailer_event" do
    it "delegates to the source" do
      latest = double(:latest_mailer_event)

      expect(source).to \
        receive(:latest_mailer_event).
        and_return(latest)

      expect(insight.latest_mailer_event).to eq(latest)
    end
  end
end
