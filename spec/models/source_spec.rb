require "spec_helper"

describe Source do
  describe "#to_s" do
    it "is the source name" do
      source = Source.new(stub(:app), "PostsController#new")
      expect(source.to_s).to eq("PostsController#new")
    end
  end

  def build_transaction(*params)
    Transaction.make!(
      {
        app: app,
        controller: "PostsController",
        action: "new"
      }.merge(*params)
    )
  end

  describe "#db" do
    let(:app) { App.make! }
    let(:source) { Source.new(app, "PostsController#new") }

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
    let(:app) { App.make! }
    let(:source) { Source.new(app, "PostsController#new") }

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
    let(:app) { App.make! }
    let(:source) { Source.new(app, "PostsController#new") }

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
