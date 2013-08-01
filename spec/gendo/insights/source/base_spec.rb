require "spec_helper"

describe Insights::Source::Base do
  module Insights
    module Source
      class NeedsMoreDog < Insights::Source::Base; end
    end
  end

  describe ".partial_name" do
    let(:insight) { Insights::Source::NeedsMoreDog.new(double(:source)) }

    it "is the underscored class name" do
      expect(insight.partial_name).to eq("/insights/source/needs_more_dog")
    end
  end
end
