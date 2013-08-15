shared_examples "an object with a decorated duration" do
  describe "#duration" do
    it "returns the duration rounded to two decimal places as ms" do
      object = double(duration: 1.2345)
      decorated = described_class.new(object)

      expect(decorated.duration).to eq("1.23 ms")
    end
  end
end
