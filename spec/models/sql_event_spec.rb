require "spec_helper"

describe SqlEvent do
  describe "#cached?" do
    context "when the event name is 'CACHED'" do
      it "is true" do
        event = SqlEvent.new(name: "CACHED")

        expect(event.cached?).to be_true
      end
    end
    context "when the event name is not 'CACHED'" do
      it "is false" do
        event = SqlEvent.new(name: "SqlEvent Load")

        expect(event.cached?).to be_false
      end
    end
  end
end
