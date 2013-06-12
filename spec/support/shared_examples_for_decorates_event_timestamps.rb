shared_examples "an object with decorated event timestamps" do
  describe "#started_at" do
    it "provides a nanosecond-precision timestamp string" do
      object = stub(started_at: Time.new(2013, 6, 11, 23, 35, 9.1234567))
      decorated = described_class.new(object)
      expect(decorated.started_at).to eq('2013-06-11 23:35:09.123456')
    end
  end

  describe "#ended_at" do
    it "provides a nanosecond-precision timestamp string" do
      object = stub(ended_at: Time.new(2013, 6, 11, 23, 35, 9.1234567))
      decorated = described_class.new(object)
      expect(decorated.ended_at).to eq('2013-06-11 23:35:09.123456')
    end
  end
end
