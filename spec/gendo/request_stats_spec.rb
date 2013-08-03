require "spec_helper"

describe RequestStats do
  def build_request(params={})
    Request.make!({
      view_runtime: 1,
      source: source
    }.merge(params))
  end

  let(:source) { Source.make! }
  let!(:t1) { build_request(db_runtime: 2) }
  let!(:t2) { build_request(db_runtime: 1) }
  let!(:t3) { build_request(db_runtime: 3) }

  subject(:stats) {
    RequestStats.new(source.requests, :db_runtime)
  }

  describe "#median" do
    it "returns the median of the source's db_runtimes" do
      expect(stats.median).to eq(2)
    end
  end

  describe "#min" do
    it "returns the minimum of the request db_runtimes" do
      expect(stats.min).to eq(t2)
    end
  end

  describe "#max" do
    it "returns the maximum of the request db_runtimes" do
      expect(stats.max).to eq(t3)
    end
  end
end
