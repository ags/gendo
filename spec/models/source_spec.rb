require "spec_helper"

describe Source do
  describe ".from_param!" do
    it "finds by name" do
      source = Source.make!(controller: "PostsController", action: "new")
      expect(Source.from_param!("PostsController#new")).to eq(source)
    end

    context "when no such Source exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          Source.from_param!("PostsController#new")
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
     it "returns the name" do
      source = Source.make!
      expect(source.to_param).to eq(source.name)
     end
  end

  def build_transaction(params={})
    Transaction.make!(params.merge(source: source))
  end

  describe "#db" do
    let(:source) { Source.make! }

    let!(:t1) { build_transaction(db_runtime: 2) }
    let!(:t2) { build_transaction(db_runtime: 1) }
    let!(:t3) { build_transaction(db_runtime: 3) }

    describe "#median" do
      it "returns the median of the source's db_runtimes" do
        expect(source.db.median).to eq(2)
      end
    end

    describe "#min" do
      it "returns the minimum of the source's db_runtimes" do
        expect(source.db.min).to eq(t2)
      end
    end

    describe "#max" do
      it "returns the maximum of the source's db_runtimes" do
        expect(source.db.max).to eq(t3)
      end
    end
  end

  describe "#view" do
    let(:source) { Source.make! }

    let!(:t1) { build_transaction(view_runtime: 2) }
    let!(:t2) { build_transaction(view_runtime: 1) }
    let!(:t3) { build_transaction(view_runtime: 3) }

    describe "#median" do
      it "returns the median of the source's view_runtimes" do
        expect(source.view.median).to eq(2)
      end
    end

    describe "#min" do
      it "returns the minimum of the source's view_runtimes" do
        expect(source.view.min).to eq(t2)
      end
    end

    describe "#max" do
      it "returns the maximum of the source's view_runtimes" do
        expect(source.view.max).to eq(t3)
      end
    end
  end

  describe "#duration" do
    let(:source) { Source.make! }

    let!(:t1) { build_transaction(duration: 2) }
    let!(:t2) { build_transaction(duration: 1) }
    let!(:t3) { build_transaction(duration: 3) }

    describe "#median" do
      it "returns the median of the source's durations" do
        expect(source.duration.median).to eq(2)
      end
    end

    describe "#min" do
      it "returns the minimum of the source's durations" do
        expect(source.duration.min).to eq(t2)
      end
    end

    describe "#max" do
      it "returns the maximum of the source's durations" do
        expect(source.duration.max).to eq(t3)
      end
    end
  end
end
