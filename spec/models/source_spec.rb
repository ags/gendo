require "spec_helper"

describe Source do
  describe ".from_param!" do
    it "finds by id" do
      source = Source.make!(id: 123, controller: "PostsController", action: "new")
      expect(Source.from_param!("123-PostsController#new")).to eq(source)
    end

    context "when no such Source exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          Source.from_param!("123-PostsController#new")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#name" do
    it "returns the controller and action" do
      source = Source.make!(controller: "PostsController", action: "new")
      expect(source.name).to eq("PostsController#new")
    end
  end

  describe "#to_param" do
    it "returns the id hyphentated with name" do
      source = Source.make!
      expect(source.to_param).to eq("#{source.id}-#{source.name}")
    end
  end

  describe "#latest_requests" do
    let(:source) { Source.make! }
    let!(:a) { Request.make!(source: source, created_at: 3.days.ago) }
    let!(:b) { Request.make!(source: source, created_at: 1.days.ago) }
    let!(:c) { Request.make!(source: source, created_at: 2.days.ago) }

    it "returns associated request sorted by most recently created" do
      expect(source.latest_requests).to eq([b, c, a])
    end

    it "can be limited to a subset of results" do
      expect(source.latest_requests(limit: 1)).to eq([b])
    end
  end
end
