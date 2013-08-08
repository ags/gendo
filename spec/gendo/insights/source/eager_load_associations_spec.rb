require "spec_helper"

describe Insights::Source::EagerLoadAssociations do
  describe "#applicable?" do
    let(:source) { Source.make! }
    let(:insight) { Insights::Source::EagerLoadAssociations.new(source) }

    context "when one or more of the 10 most recent associated requests has an n+1 query" do
      it "is true" do
        requests = 10.times.map { Request.create!(source: source) }
        NPlusOneQuery.make!(request: requests[0])

        expect(insight.applicable?).to be_true
      end
    end

    context "when none of the 10 most recent associated requests has an n+1 query" do
      it "is false" do
        requests = 11.times.map { Request.create!(source: source) }
        NPlusOneQuery.make!(request: requests[0])

        expect(insight.applicable?).to be_false
      end
    end

    context "when no associated requests include NPlusOneQueries" do
      it "is false" do
        Request.make!(source: source)

        expect(insight.applicable?).to be_false
      end
    end
  end
end
