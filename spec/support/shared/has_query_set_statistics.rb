shared_examples "a query set with timing statistics" do
  describe "#percentage_of_db_runtime" do
    let(:query) { double(duration: 33) }
    let(:decorated) { described_class.new(query) }

    it "returns the percentage of db_runtime consumed by the query" do
      allow(decorated).to \
        receive(:request).
        and_return(double(:request, db_runtime: "37 ms"))

      expect(decorated.percentage_of_db_runtime).to eq(89.19)
    end

    context "with a zero db_runtime" do
      it "is zero" do
        allow(decorated).to \
          receive(:request).
          and_return(double(:request, db_runtime: "0 ms"))

        expect(decorated.percentage_of_db_runtime).to eq(0)
      end
    end
  end

  context "#percentage_of_request_duration" do
    let(:query) { double(duration: 33) }
    let(:decorated) { described_class.new(query) }

    it "returns the percentage of db_runtime consumed by the query" do
      allow(decorated).to \
        receive(:request).
        and_return(double(:request, duration: "270 ms"))

      expect(decorated.percentage_of_request_duration).to eq(12.22)
    end

    context "with a zero db_runtime" do
      it "is zero" do
        allow(decorated).to \
          receive(:request).
          and_return(double(:request, duration: "0 ms"))

        expect(decorated.percentage_of_request_duration).to eq(0)
      end
    end
  end
end
