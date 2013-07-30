require 'spec_helper'

describe Gendo::Insights do
  describe ".all" do
    # NOTE this may be unmaintable and better tested by integration
    it "is a list of all Insights classes" do
      expect(Gendo::Insights.all).to eq([
        Gendo::Insights::SendEmailAsync,
        Gendo::Insights::EagerLoadAssociations,
      ])
    end
  end

  describe "#applicable_to_source" do
    class ApplicableIns < Gendo::Insights::Base
      def applicable?; true; end
    end
    class UnapplicableIns < Gendo::Insights::Base
      def applicable?; false; end
    end

    before do
      Gendo::Insights.stub(:all).and_return([ApplicableIns, UnapplicableIns])
    end

    let(:source) { double(:source) }
    subject(:applicable) { Gendo::Insights.applicable_to_source(source) }

    it "returns all Insights applicable to the given source" do
      expect(applicable.size).to eq(1)
      expect(applicable.first).to be_a(ApplicableIns)
    end
  end
end
