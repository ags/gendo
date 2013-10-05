shared_examples_for "an action requiring authentication as the App's User" do
  let(:app_access) { class_double("AppAccess").as_stubbed_const }
  let(:app) { double(:app, to_param: 1).as_null_object }

  before do
    allow(controller).to \
      receive(:app).
      and_return(app)

    expect(app_access).to \
      receive(:permitted?).
      and_return(accessible)
  end

  context "when the app is accessible" do
    let(:accessible) { true }

    it "is accessible" do
      action!

      expect(response.status).to eq(200)
    end
  end

  context "when the app is not accessible" do
    let(:accessible) { false }

    it "requires login" do
      action!

      expect(response.status).to eq(401)
      expect(response).to render_template("statics/unauthorized")
    end
  end
end
