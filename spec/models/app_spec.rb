require "spec_helper"

describe App do
  it "requires a user" do
    app = App.new
    expect(app.valid?).to be_false
    expect(app.errors.messages[:user]).to eq(["can't be blank"])
  end

  it "requires a name" do
    app = App.new
    expect(app.valid?).to be_false
    expect(app.errors.messages[:name]).to eq(["can't be blank"])
  end

  it "sets a slug on name assignment" do
    app = App.new(name: "Shinji Ikari")
    expect(app.slug).to eq("shinji-ikari")
  end

  describe ".from_param" do
    it "returns the App with the given id + slug" do
      app = App.make!
      expect(App.from_param(app.to_param)).to eq(app)
    end

    context "when no such app exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          App.from_param("rei")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe ".with_access_token!" do
    it "returns the App associated with the given access token" do
      token = AppAccessToken.make!(token: "mah-token")
      expect(App.with_access_token!("mah-token")).to eq(token.app)
    end

    context "no such App exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          App.with_access_token!("wat")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#to_param" do
    it "returns the App id + slug" do
      app = App.make!
      expect(app.to_param).to eq("#{app.id}-#{app.slug}")
    end
  end

  describe "#current_access_token" do
    it "returns the associated UserAccessToken currently in-use" do
      token = AppAccessToken.make!
      app = token.app
      expect(app.current_access_token).to eq(token)
    end
  end

  describe "#sources_by_median_desc" do
    it "returns the top n Sources for a field sorted by their median value" do
      app = App.make!
      source_a_1 = Source.make!(app: app, controller: "A", action: "a")
      source_a_2 = Source.make!(app: app, controller: "A", action: "b")
      source_b_1 = Source.make!(app: app, controller: "B", action: "a")
      source_b_2 = Source.make!(app: app, controller: "B", action: "b")

      Transaction.make!(source: source_a_1, db_runtime: 1)
      Transaction.make!(source: source_a_2, db_runtime: 2)
      Transaction.make!(source: source_b_1, db_runtime: 0)
      Transaction.make!(source: source_b_2, db_runtime: 9)
      Transaction.make!(source: source_b_2, db_runtime: 4)

      expect(app.sources_by_median_desc(:db_runtime, limit: 2)).to eq([
        source_b_2,
        source_a_2
      ])
    end
  end
end
