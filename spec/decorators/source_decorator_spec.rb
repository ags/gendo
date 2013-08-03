require 'draper'
require './app/gendo/insights/source'
require './app/gendo/request_stats'
require './app/decorators/source_decorator'

Draper::ViewContext.test_strategy :fast

class Source; end

describe SourceDecorator do
  subject(:decorated) { SourceDecorator.new(source) }

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

    class FooIns; end

    it "is a list of applicable insight classes" do
      Insights::Source.stub(:applicable_to) { [FooIns] }

      expect(decorated.insights).to eq([FooIns])
    end
  end
end
