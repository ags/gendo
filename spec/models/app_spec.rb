require "spec_helper"

describe App do
  it "requires a user"
  it "requires a name"

  it "sets a slug on name assignment" do
    app = App.new(name: "Shinji Ikari")
    expect(app.slug).to eq("shinji-ikari")
  end

  describe "#from_param" do
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

  describe "#to_param" do
    it "returns the App id + slug" do
      app = App.make!
      expect(app.to_param).to eq("#{app.id}-#{app.slug}")
    end
  end
end
