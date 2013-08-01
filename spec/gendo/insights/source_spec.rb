require "spec_helper"

describe Insights::Source do
  describe ".all" do
    # NOTE this may be unmaintable and better tested by integration
    it "is a list of all Insights classes" do
      expect(Insights::Source.all).to eq([
        Insights::Source::SendEmailAsync,
        Insights::Source::EagerLoadAssociations,
      ])
    end
  end

  describe "#applicable_to" do
    class ApplicableIns < Insights::Source::Base
      def applicable?; true; end
    end
    class UnapplicableIns < Insights::Source::Base
      def applicable?; false; end
    end

    before do
      Insights::Source.stub(:all).and_return([ApplicableIns, UnapplicableIns])
    end

    let(:source) { double(:source) }
    subject(:applicable) { Insights::Source.applicable_to(source) }

    it "returns all Insights applicable to the given source" do
      expect(applicable.size).to eq(1)
      expect(applicable.first).to be_a(ApplicableIns)
    end
  end
end
