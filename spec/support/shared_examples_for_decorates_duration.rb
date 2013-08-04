shared_examples "an object with a decorated duration" do
  describe "#duration" do
    it "returns the duration with the millisecond time unit" do
      object = double(duration: 1.234)
      decorated = described_class.new(object)

      expect(decorated.duration).to eq("1.234 ms")
    end
  end
end
