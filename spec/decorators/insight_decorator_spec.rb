require "draper"
require_relative "../../app/decorators/insight_decorator"

describe InsightDecorator do
  describe ".partial_name" do
    it "is the underscored class name" do
      module Insights; module Test; class NeedsMoreDog; end; end; end
      insight = Insights::Test::NeedsMoreDog.new
      decorated = InsightDecorator.decorate(insight)

      expect(decorated.partial_name).to eq("/insights/test/needs_more_dog")
    end
  end
end
