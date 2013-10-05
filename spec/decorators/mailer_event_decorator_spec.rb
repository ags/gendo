require "draper"
require_relative "../support/shared/decorates_duration"
require_relative "../support/shared/decorates_event_timestamps"
require_relative "../support/shared/has_undecorated_class_name"
require_relative "../../app/decorators/decorates_event_timestamps"
require_relative "../../app/decorators/has_undecorated_class_name"
require_relative "../../app/decorators/decorates_duration"
require_relative "../../app/decorators/mailer_event_decorator"

describe MailerEventDecorator do
  it_behaves_like "an object with decorated event timestamps"

  it_behaves_like "a decorator with undecorated class name methods"

  it_behaves_like "an object with a decorated duration"

  describe "#app_name" do
    it "delegates to the associated app" do
      decorated = MailerEventDecorator.new(double(:mailer_event))

      allow(decorated).to \
        receive(:app).
        and_return(double(:app, name: "mah app"))

      expect(decorated.app_name).to eq("mah app")
    end
  end

  describe "#source_name" do
    it "delegates to the associated source" do
      decorated = MailerEventDecorator.new(double(:mailer_event))

      allow(decorated).to \
        receive(:source).
        and_return(double(:source, name: "mah source"))

      expect(decorated.source_name).to eq("mah source")
    end
  end

  describe "#request_name" do
    it "delegates to the associated request" do
      decorated = MailerEventDecorator.new(double(:mailer_event))

      allow(decorated).to \
        receive(:request).
        and_return(double(:request, name: "mah request"))

      expect(decorated.request_name).to eq("mah request")
    end
  end
end
