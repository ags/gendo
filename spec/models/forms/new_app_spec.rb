require "spec_helper"

describe Forms::NewApp do
  let(:user) { User.make! }

  it "creates a new App" do
    form = Forms::NewApp.new(user, name: "Shinji")
    form.save!
    expect(form.app.name).to eq("Shinji")
    expect(form.app.user).to eq(user)
  end

  context "without a name" do
    it "is invalid" do
      form = Forms::NewApp.new(user)
      expect(form.valid?).to be_false
      expect(form.save!).to be_false
    end
  end
end
