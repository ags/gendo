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

  describe "RequestStats" do
    let(:source) { double(:source, requests: double(:requests)) }
    let(:request_stats) { class_double("RequestStats").as_stubbed_const }

    describe "#db" do
      it "is RequestStats for db_runtime" do
        db_stats = double(:db_stats)

        expect(request_stats).to \
          receive(:new).
          with(source.requests, :db_runtime).
          and_return(db_stats)

        expect(decorated.db).to eq(db_stats)
      end
    end

    describe "#view" do
      it "is RequestStats for view_runtime" do
        view_stats = double(:view_stats)

        expect(request_stats).to \
          receive(:new).
          with(source.requests, :view_runtime).
          and_return(view_stats)

        expect(decorated.view).to eq(view_stats)
      end
    end

    describe "#duration" do
      it "is RequestStats for duration" do
        duration_stats = double(:duration_stats)

        expect(request_stats).to \
          receive(:new).
          with(source.requests, :duration).
          and_return(duration_stats)

        expect(decorated.duration).to eq(duration_stats)
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
