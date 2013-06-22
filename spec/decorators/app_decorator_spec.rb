require 'draper'
require './spec/support/shared_examples_for_decorates_event_timestamps'
require './app/decorators/app_decorator'

Draper::ViewContext.test_strategy :fast

class App; end

describe AppDecorator do
  let(:app) { stub(:app) }
  subject(:decorated) { AppDecorator.new(app) }

  describe "#alphabetized_sources" do
    it "orders sources by their controller and action" do
      decorated_sources = stub(:decorated_sources)
      sources = stub(:sources, decorate: decorated_sources)

      app.stub(:sources) { sources }
      sources.
        should_receive(:order).
        with(:controller, :action).
        and_return(sources)

      expect(decorated.alphabetized_sources).to eq(decorated_sources)
    end
  end

  describe "#worst_sources_by_db_runtime" do
    it "delegates to App#sources_by_median_desc for db_runtime" do
      decorated_worst_sources = stub(:decorated_worst_sources)

      app.should_receive(:sources_by_median_desc).
        with(:db_runtime, limit: 3).
        and_return(stub(:worst_sources, decorate: decorated_worst_sources))

      expect(decorated.worst_sources_by_db_runtime).to \
        eq(decorated_worst_sources)
    end
  end

  describe "#worst_sources_by_view_runtime" do
    it "delegates to App#sources_by_median_desc for view_runtime" do
      decorated_worst_sources = stub(:decorated_worst_sources)

      app.should_receive(:sources_by_median_desc).
        with(:view_runtime, limit: 3).
        and_return(stub(:worst_sources, decorate: decorated_worst_sources))

      expect(decorated.worst_sources_by_view_runtime).to \
        eq(decorated_worst_sources)
    end
  end

  describe "#collecting_data?" do
    let(:app) { stub(:app, sources: sources) }

    context "with sources" do
      let(:sources) { [stub(:source, decorate: stub)] }

      it "is true" do
        expect(decorated.collecting_data?).to be_true
      end
    end

    context "with no sources" do
      let(:sources) { [] }

      it "is false" do
        expect(decorated.collecting_data?).to be_false
      end
    end
  end

  describe "#internal_server_errors" do
    it "returns transactions with status 500" do
      decorated_transactions = stub(:decorated_transactions)

      app.
        should_receive(:recent_transactions_with_status).
        with(500, limit: 3).
        and_return(stub(:transactions, decorate: decorated_transactions))

      expect(decorated.recent_internal_server_errors).to \
        eq(decorated_transactions)
    end
  end
end
