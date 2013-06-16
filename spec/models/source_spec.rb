require "spec_helper"

describe Source do
  describe "#to_s" do
    it "is the source name" do
      source = Source.new(stub(:app), "PostsController#new")
      expect(source.to_s).to eq("PostsController#new")
    end
  end

  describe Source::DBStats do
    let(:app) { App.make! }
    let(:source) { Source.new(app, "PostsController#new") }

    def build_transaction(*params)
      Transaction.make!(
        {
          app: app,
          controller: "PostsController",
          action: "new"
        }.merge(*params)
      )
    end

    describe "#median" do
      it "returns the median of the source's db_runtimes" do
        t1 = build_transaction(db_runtime: 2)
        t2 = build_transaction(db_runtime: 1)
        t3 = build_transaction(db_runtime: 3)

        expect(source.db.median).to eq(2)
      end
    end

    describe "#min" do
      it "returns the minimum of the source's db_runtimes" do
        t1 = build_transaction(db_runtime: 2)
        t2 = build_transaction(db_runtime: 1)
        t3 = build_transaction(db_runtime: 3)

        expect(source.db.min).to eq(t2)
      end
    end

    describe "#max" do
      it "returns the maximum of the source's db_runtimes" do
        t1 = build_transaction(db_runtime: 2)
        t2 = build_transaction(db_runtime: 1)
        t3 = build_transaction(db_runtime: 3)

        expect(source.db.max).to eq(t3)
      end
    end
  end
end
