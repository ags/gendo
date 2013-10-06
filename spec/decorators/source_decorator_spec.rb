require 'draper'
require_relative '../../app/decorators/source_decorator'

describe SourceDecorator do
  subject(:decorated) { SourceDecorator.new(source) }

  describe "#app_name" do
    let(:app) { double(:app, name: "mah app") }
    let(:source) { double(:source, app: app) }

    it "delegates to the associated app" do
      expect(decorated.app_name).to eq("mah app")
    end
  end

  describe "#latest_requests" do
    let(:source) { double(:source, requests: double(:requests)) }

    it "returns decorated requests" do
      decorated_requests = double(:decorated_requests)

      expect(source).to \
        receive(:latest_requests).
        and_return(double(:latest, decorate: decorated_requests))

      expect(decorated.latest_requests).to eq(decorated_requests)
    end
  end

  describe "#has_requests?" do
    let(:source) { double(:source, requests: requests) }

    context "with associated requests" do
      let(:requests) { [double(:request)] }

      it "is true" do
        expect(decorated.has_requests?).to eq(true)
      end
    end

    context "without associated requests" do
      let(:requests) { [] }

      it "is false" do
        expect(decorated.has_requests?).to eq(false)
      end
    end
  end

  describe "median request statistics" do
    let(:requests) { double(:requests) }
    let(:source) { double(:source, requests: requests) }

    describe "#median_request_duration" do
      it "is the median duration for associated requests" do
        median_duration = double(:median_duration)

        expect(requests).to \
          receive(:median).
          with(:duration).
          and_return(median_duration)

        expect(decorated.median_request_duration).to eq(median_duration)
      end
    end

    describe "#median_request_db_runtime" do
      it "is the median db_runtime for associated requests" do
        median_db_runtime = double(:median_db_runtime)

        expect(requests).to \
          receive(:median).
          with(:db_runtime).
          and_return(median_db_runtime)

        expect(decorated.median_request_db_runtime).to eq(median_db_runtime)
      end
    end

    describe "#median_request_view_runtime" do
      it "is the median view_runtime for associated requests" do
        median_view_runtime = double(:median_view_runtime)

        expect(requests).to \
          receive(:median).
          with(:view_runtime).
          and_return(median_view_runtime)

        expect(decorated.median_request_view_runtime).to eq(median_view_runtime)
      end
    end
  end

  describe "#insights" do
    let(:source) { double(:source) }

    it "is a list of applicable insight classes" do
      applicable_insights = double(:applicable_insights)
      decorated_insights  = double(:decorated_insights)

      source_insights = class_double("Insights::Source").as_stubbed_const
      insight_decorator = class_double("InsightDecorator").as_stubbed_const

      expect(source_insights).to \
        receive(:applicable_to).
        with(source).
        and_return(applicable_insights)

      expect(insight_decorator).to \
        receive(:decorate_collection).
        with(applicable_insights).
        and_return(decorated_insights)

      expect(decorated.insights).to eq(decorated_insights)
    end
  end
end
