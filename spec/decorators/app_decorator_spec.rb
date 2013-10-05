require 'draper'
require_relative '../../app/decorators/app_decorator'

describe AppDecorator do
  let(:app) { instance_double("App", sources: sources) }
  subject(:decorated) { AppDecorator.new(app) }

  describe "#alphabetized_sources" do
    let(:decorated_sources) { double(:decorated_sources) }
    let(:sources) { double(:sources, decorate: decorated_sources) }

    it "orders sources by their controller and action" do
      expect(sources).to \
        receive(:order).
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
        expect(decorated.collecting_data?).to eq(true)
      end
    end

    context "with no sources" do
      let(:sources) { [] }

      it "is false" do
        expect(decorated.collecting_data?).to eq(false)
      end
    end
  end
end
