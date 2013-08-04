require 'draper'
require './spec/support/shared_examples_for_decorates_duration'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/gendo/insights/request'
require './app/decorators/decorates_event_timestamps'
require './app/decorators/decorates_duration'
require './app/decorators/insight_decorator'
require './app/decorators/request_decorator'

Draper::ViewContext.test_strategy :fast

class Request; end

describe RequestDecorator do
  it_behaves_like "an object with decorated event timestamps"
  it_behaves_like "an object with a decorated duration"

  subject(:decorated) { RequestDecorator.new(request) }

  describe "#events" do
    let(:a) { double(:a, started_at: 1.minute.ago).as_null_object }
    let(:b) { double(:b, started_at: 2.minutes.ago).as_null_object }
    let(:c) { double(:c, started_at: 30.seconds.ago).as_null_object }
    let(:d) { double(:d, started_at: 15.seconds.ago).as_null_object }
    let(:request) {
      double(sql_events: [a, c], view_events: [b], mailer_events: [d])
    }

    it "combines sql and view events ordered by started_at" do
      expect(decorated.events).to eq([b, a, c, d])
    end
  end

  describe "#db_runtime" do
    let(:request) { double(db_runtime: 1.234) }

    it "returns the db runtime and millsecond time unit" do
      expect(decorated.db_runtime).to eq("1.234 ms")
    end
  end

  describe "#view_runtime" do
    let(:request) { double(view_runtime: 1.234) }

    it "returns the view runtime and millsecond time unit" do
      expect(decorated.view_runtime).to eq("1.234 ms")
    end
  end

  describe "#name" do
    let(:request) { double(:request, id: 123) }

    it "is the request id" do
      expect(decorated.name).to eq("Request 123")
    end
  end

  describe "#source_name" do
    let(:request) { double(:request, source: double(:source, name: "foobar")) }

    it "delegates to the associated source" do
      expect(decorated.source_name).to eq("foobar")
    end
  end

  describe "#app_name" do
    let(:request) { double(:request, app: double(:app, name: "barfoo")) }

    it "delegates to the associated app" do
      expect(decorated.app_name).to eq("barfoo")
    end
  end

  describe "#collected_timings?" do

    context "with a db_runtime and view_runtime" do
      let(:request) { double(:request, db_runtime: 1, view_runtime: 2) }

      it "is true" do
        expect(decorated.collected_timings?).to be_true
      end
    end

    context "with just a db_runtime" do
      let(:request) { double(:request, db_runtime: 1, view_runtime: nil) }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end

    context "with just a view_runtime" do
      let(:request) { double(:request, db_runtime: nil, view_runtime: 2) }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end

    context "with neither db_runtime nor view_runtime" do
      let(:request) { double(:request, db_runtime: nil, view_runtime: nil) }

      it "is false" do
        expect(decorated.collected_timings?).to be_false
      end
    end
  end

  describe "#time_breakdown_graph_data" do
    let(:request) { double(:request, db_runtime: 1, view_runtime: 2) }

    it "returns db and view runtimes formatted for morris.js" do
      expect(decorated.time_breakdown_graph_data).to eq([
        {label: "Database", value: 1},
        {label: "Views", value: 2}
      ])
    end
  end

  describe "#fuzzy_timestamp" do
    it "is a fuzzy timestamp of created_at" do
      request = double(:request, created_at: 57.minutes.ago)
      decorated = RequestDecorator.new(request)
      expect(decorated.fuzzy_timestamp).to eq("about 1 hour ago")
    end
  end

  describe "#insights" do
    let(:request) { double(:request) }

    it "is a list of applicable insight classes" do
      applicable_insight = double(:applicable_insight)
      decorated_insights = double(:decorated_insights)

      expect(InsightDecorator).to \
        receive(:decorate_collection).
        with([applicable_insight]).
        and_return(decorated_insights)

      Insights::Request.stub(:applicable_to) { [applicable_insight] }

      expect(decorated.insights).to eq(decorated_insights)
    end
  end
end