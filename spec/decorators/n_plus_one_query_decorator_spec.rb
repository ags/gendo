require "draper"
require_relative "../support/shared/decorates_duration"
require_relative "../../app/decorators/decorates_duration"
require_relative "../../app/decorators/n_plus_one_query_decorator"

describe NPlusOneQueryDecorator do
  it_behaves_like "an object with a decorated duration"

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

  describe "#percentage_of_db_runtime" do
    let(:query) { double(duration: 33) }
    let(:decorated) { NPlusOneQueryDecorator.new(query) }

    it "returns the percentage of db_runtime consumed by the query" do
      allow(decorated).to \
        receive(:request).
        and_return(double(:request, db_runtime: "37 ms"))

      expect(decorated.percentage_of_db_runtime).to eq(89.19)
    end

    context "with a zero db_runtime" do
      it "is zero" do
        allow(decorated).to \
          receive(:request).
          and_return(double(:request, db_runtime: "0 ms"))

        expect(decorated.percentage_of_db_runtime).to eq(0)
      end
    end
  end

  context "#percentage_of_request_duration" do
    let(:query) { double(duration: 33) }
    let(:decorated) { NPlusOneQueryDecorator.new(query) }

    it "returns the percentage of db_runtime consumed by the query" do
      allow(decorated).to \
        receive(:request).
        and_return(double(:request, duration: "270 ms"))

      expect(decorated.percentage_of_request_duration).to eq(12.22)
    end

    context "with a zero db_runtime" do
      it "is zero" do
        allow(decorated).to \
          receive(:request).
          and_return(double(:request, duration: "0 ms"))

        expect(decorated.percentage_of_request_duration).to eq(0)
      end
    end
  end
end
