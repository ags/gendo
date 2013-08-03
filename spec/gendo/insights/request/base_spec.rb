require "spec_helper"

describe Insights::Request::Base do
  module Insights
    module Request
      class NeedsMoreCat < Insights::Request::Base; end
    end
  end

  describe ".partial_name" do
    let(:insight) { Insights::Request::NeedsMoreCat.new(double(:request)) }

    it "is the underscored class name" do
      expect(insight.partial_name).to eq("/insights/request/needs_more_cat")
    end
  end
end
