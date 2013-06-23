require "spec_helper"

describe Gendo::Insights::Base do
  module Gendo; module Dog;
    class NeedsMore < Gendo::Insights::Base; end
  end; end

  describe ".partial_name" do
    let(:insight) { Gendo::Dog::NeedsMore }

    it "is the underscored class name" do
      expect(insight.partial_name).to eq("needs_more")
    end
  end
end
