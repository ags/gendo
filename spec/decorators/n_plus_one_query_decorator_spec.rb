require "draper"
require_relative "../support/shared/decorates_duration"
require_relative "../support/shared/has_query_set_statistics"
require_relative "../../app/decorators/decorates_duration"
require_relative "../../app/decorators/n_plus_one_query_decorator"

describe NPlusOneQueryDecorator do
  it_behaves_like "an object with a decorated duration"

  it_behaves_like "a query set with timing statistics"

  describe "#source_name" do
    it "delegates to the associated source" do
      decorated = NPlusOneQueryDecorator.new(double(:query))

      allow(decorated).to \
        receive(:source).
        and_return(double(:source, name: "sauce name"))

      expect(decorated.source_name).to eq("sauce name")
    end
  end

  describe "#app_name" do
    it "delegates to the associated app" do
      decorated = NPlusOneQueryDecorator.new(double(:query))

      allow(decorated).to \
        receive(:app).
        and_return(double(:app, name: "mah app"))

      expect(decorated.app_name).to eq("mah app")
    end
  end

  describe "#request_name" do
    it "delegates to the associated request" do
      decorated = NPlusOneQueryDecorator.new(double(:query))

      allow(decorated).to \
        receive(:request).
        and_return(double(:request, name: "dat request"))

      expect(decorated.request_name).to eq("dat request")
    end
  end
end
