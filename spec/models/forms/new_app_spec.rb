require "spec_helper"

describe Forms::NewApp do
  let(:user) { User.make! }
  subject(:form) { Forms::NewApp.new(user, name: "Shinji") }

  it "creates a new App" do
    form.save!
    expect(form.app.name).to eq("Shinji")
    expect(form.app.user).to eq(user)
  end
  
  it "creates an AppAccessToken for the created App" do
    form.save!
    expect(form.app.current_access_token).to be_present
  end

  context "without a name" do
    subject(:form) { Forms::NewApp.new(user) }

    it "is invalid" do
      expect(form.valid?).to be_false
      expect(form.save!).to be_false
    end
  end
end
