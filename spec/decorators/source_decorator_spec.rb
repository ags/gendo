require 'draper'
require './app/gendo/insights/source'
require './app/gendo/request_stats'
require './app/decorators/insight_decorator'
require './app/decorators/source_decorator'

Draper::ViewContext.test_strategy :fast

class Source; end

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
        expect(decorated.has_requests?).to be_true
      end
    end

    context "without associated requests" do
      let(:requests) { [] }

      it "is false" do
        expect(decorated.has_requests?).to be_false
      end
    end
  end

  describe "RequestStats" do
    let(:source) { double(:source, requests: double(:requests)) }

    describe "#db" do
      it "is RequestStats for db_runtime" do
        expect(decorated.db).to \
          eq(RequestStats.new(source.requests, :db_runtime))
      end
    end

    describe "#view" do
      it "is RequestStats for view_runtime" do
        expect(decorated.view).to \
          eq(RequestStats.new(source.requests, :view_runtime))
      end
    end

    describe "#duration" do
      it "is RequestStats for view_runtime" do
        expect(decorated.duration).to \
          eq(RequestStats.new(source.requests, :duration))
      end
    end
  end

  describe "#insights" do
    let(:source) { double(:source) }

    it "is a list of applicable insight classes" do
      applicable_insight = double(:applicable_insight)
      decorated_insights = double(:decorated_insights)

      expect(InsightDecorator).to \
        receive(:decorate_collection).
        with([applicable_insight]).
        and_return(decorated_insights)

      Insights::Source.stub(:applicable_to) { [applicable_insight] }

      expect(decorated.insights).to eq(decorated_insights)
    end
  end
end
