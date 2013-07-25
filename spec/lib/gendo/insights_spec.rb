require 'spec_helper'

describe Gendo::Insights do
  describe ".all" do
    # NOTE this may be unmaintable and better tested by integration
    it "is a list of all Insights classes" do
      expect(Gendo::Insights.all).to eq([
        Gendo::Insights::SendEmailAsync
      ])
    end
  end

  describe "#applicable_to_source" do
    class FooIns; def self.applicable_to_source?(*); true; end; end
    class BarIns; def self.applicable_to_source?(*); false; end; end

    before do
      Gendo::Insights.stub(:all).and_return([FooIns, BarIns])
    end

    let(:source) { double(:source) }
    subject(:applicable) { Gendo::Insights.applicable_to_source(source) }

    it "returns all Insights applicable to the given source" do
      expect(applicable).to eq([FooIns])
    end
  end
end
