require "spec_helper"

describe SqlEvent do
  describe "#cached?" do
    context "with a name of 'CACHED'" do
      it "is true" do
        event = SqlEvent.new(name: "CACHED")

        expect(event.cached?).to be_true
      end
    end
  end
end
