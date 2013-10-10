require "draper"
require_relative "../support/shared/decorates_duration"
require_relative "../support/shared/has_query_set_statistics"
require_relative "../../app/decorators/decorates_duration"
require_relative "../../app/decorators/counter_cacheable_query_set_decorator"

describe CounterCacheableQuerySetDecorator do
  subject(:decorated) { CounterCacheableQuerySetDecorator.new(double(:insertable)) }

  it_behaves_like "an object with a decorated duration"

  it_behaves_like "a query set with timing statistics"

  describe "#source_name" do
    it "delegates to the associated source" do
      allow(decorated).to \
        receive(:source).
        and_return(double(:source, name: "sauce name"))

      expect(decorated.source_name).to eq("sauce name")
    end
  end

  describe "#app_name" do
    it "delegates to the associated app" do
      allow(decorated).to \
        receive(:app).
        and_return(double(:app, name: "mah app"))

      expect(decorated.app_name).to eq("mah app")
    end
  end

  describe "#request_name" do
    it "delegates to the associated request" do
      allow(decorated).to \
        receive(:request).
        and_return(double(:request, name: "dat request"))

      expect(decorated.request_name).to eq("dat request")
    end
  end
end
