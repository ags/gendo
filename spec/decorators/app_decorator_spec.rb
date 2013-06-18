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
      sources = double(:sources)
      ordered = double(:ordered_sources)

      app.stub(:sources) { sources }
      sources.should_receive(:order).with(:controller, :action) { ordered }

      expect(decorated.alphabetized_sources).to eq(ordered)
    end
  end

  describe "#worst_sources_by_db_runtime" do
    it "delegates to App#sources_by_median_desc for db_runtime" do
      worst_sources = stub(:worst_sources)

      app.should_receive(:sources_by_median_desc).
        with(:db_runtime, limit: 3).
        and_return(worst_sources)

      expect(decorated.worst_sources_by_db_runtime).to eq(worst_sources)
    end
  end

  describe "#worst_sources_by_view_runtime" do
    it "delegates to App#sources_by_median_desc for view_runtime" do
      worst_sources = stub(:worst_sources)

      app.should_receive(:sources_by_median_desc).
        with(:view_runtime, limit: 3).
        and_return(worst_sources)

      expect(decorated.worst_sources_by_view_runtime).to eq(worst_sources)
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
end
