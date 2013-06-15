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
      it "raises App::DoesNotExist" do
        expect do
          App.from_param("rei")
        end.to raise_error(App::DoesNotExist)
      end
    end
  end

  describe ".with_access_token!" do
    it "returns the App associated with the given access token" do
      token = AppAccessToken.make!(token: "mah-token")
      expect(App.with_access_token!("mah-token")).to eq(token.app)
    end

    context "no such App exists" do
      it "raises App::DoesNotExist" do
        expect do
          App.with_access_token!("wat")
        end.to raise_error(App::DoesNotExist)
      end
    end
  end

  describe "#to_param" do
    it "returns the App id + slug" do
      app = App.make!
      expect(app.to_param).to eq("#{app.id}-#{app.slug}")
    end
  end

  describe "#latest_transactions" do
    it "returns the most recent transaction for each controller / action combination" do
      app = App.make!
      t1 = Transaction.make!(app: app, controller: "FooCtrl", action: "new")
      t2 = Transaction.make!(app: app, controller: "FooCtrl", action: "new")
      t3 = Transaction.make!(app: app, controller: "BarCtrl", action: "new")
      t4 = Transaction.make!(app: app, controller: "BarCtrl", action: "create")

      expect(app.latest_transactions).to eq([t4, t3, t2])
    end
  end

  describe "#current_access_token" do
    it "returns the associated UserAccessToken currently in-use" do
      token = AppAccessToken.make!
      app = token.app
      expect(app.current_access_token).to eq(token)
    end
  end
end
