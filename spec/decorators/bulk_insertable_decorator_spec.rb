require "draper"
require_relative "../../app/decorators/bulk_insertable_decorator"

describe BulkInsertableDecorator do
  subject(:decorated) { BulkInsertableDecorator.new(double(:insertable)) }

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
