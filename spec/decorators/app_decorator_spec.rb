require 'draper'
require './spec/support/shared/decorates_event_timestamps'
require './app/decorators/app_decorator'

Draper::ViewContext.test_strategy :fast

class App; end

describe AppDecorator do
  let(:app) { double(:app) }
  subject(:decorated) { AppDecorator.new(app) }

  describe "#alphabetized_sources" do
    it "orders sources by their controller and action" do
      decorated_sources = double(:decorated_sources)
      sources = double(:sources, decorate: decorated_sources)

      app.stub(:sources) { sources }
      sources.
        should_receive(:order).
        with(:controller, :action).
        and_return(sources)

      expect(decorated.alphabetized_sources).to eq(decorated_sources)
    end
  end

  describe "#collecting_data?" do
    let(:app) { double(:app, sources: sources) }

    context "with sources" do
      let(:sources) { [double(:source, decorate: double)] }

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
