require "active_support/core_ext/module/delegation"
require_relative "../../../../app/gendo/insights/request/base"
require_relative "../../../../app/gendo/insights/request/send_email_async"

describe Insights::Request::SendEmailAsync do
  describe "#applicable?" do
    let(:request) { instance_double("Request", mailer_events: queries) }
    let(:insight) {
      Insights::Request::SendEmailAsync.new(request)
    }

    context "with associated mailer events" do
      let(:queries) { [double(:query)] }

      it "is true" do
        expect(insight.applicable?).to eq(true)
      end
    end

    context "without associated mailer events" do
      let(:queries) { [] }

      it "is false" do
        expect(insight.applicable?).to eq(false)
      end
    end
  end
end
