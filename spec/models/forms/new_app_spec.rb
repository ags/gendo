require_relative "../../../app/models/forms/base"
require_relative "../../../app/models/forms/new_app"

describe Forms::NewApp do
  let(:user) { double(:user) }
  subject(:form) { Forms::NewApp.new(user, name: "Shinji") }

  it "creates an App for the user" do
    app_creator = double(:app_creator)
    form.app_creator = ->(attributes={}) { app_creator.create!(attributes) }

    expect(app_creator).to receive(:create!).with(name: "Shinji")
    expect(form.save!).to eq(true)
  end

  context "without a name" do
    subject(:form) { Forms::NewApp.new(user) }

    it "is invalid" do
      expect(form.valid?).to eq(false)
      expect(form.save!).to eq(false)
    end
  end
end
