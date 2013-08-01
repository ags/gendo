require "spec_helper"

describe Insights::Transaction::Base do
  module Insights
    module Transaction
      class NeedsMoreCat < Insights::Transaction::Base; end
    end
  end

  describe ".partial_name" do
    let(:insight) { Insights::Transaction::NeedsMoreCat.new(double(:transaction)) }

    it "is the underscored class name" do
      expect(insight.partial_name).to eq("/insights/transaction/needs_more_cat")
    end
  end
end
