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

end
