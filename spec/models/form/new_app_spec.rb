require_relative "../../../lib/form/model"
require_relative "../../../app/models/form/new_app"

describe Form::NewApp do
  let(:user) { double(:user) }
  subject(:form) { Form::NewApp.new(user, name: "Shinji") }

  it "creates an App for the user" do
    app_creator = class_double("CreatesAppForUser").as_stubbed_const
    app = double(:app)

    expect(app_creator).to \
      receive(:create!).
      with(user, name: "Shinji").
      and_return(app)

    expect(form.save!).to eq(true)
    expect(form.app).to eq(app)
  end

  context "without a name" do
    subject(:form) { Form::NewApp.new(user) }

    it "is invalid" do
      expect(form.valid?).to eq(false)
      expect(form.save!).to eq(false)
    end
  end
end
