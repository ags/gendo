shared_examples_for "an action requiring authentication as the App's User" do
  context "authenticated as the User associated with the Transaction App" do
    let(:user) { User.make! }
    let(:app) { App.make!(user: user) }

    before do
      controller.authenticator.sign_in(user)
      action!
    end
    
    it "is accessible" do
      expect(response.status).to eq(200)
    end
  end

  context "authenticated as a User not associated with the Transaction App" do
    let(:user) { User.make! }
    let(:app) { App.make! }

    before do
      controller.authenticator.sign_in(user)
      action!
    end

    it "requires login" do
      expect(response.status).to eq(401)
      expect(response).to render_template("statics/unauthorized")
    end
  end

  context "unauthenticated" do
    before do
      action!
    end

    it "requires login" do
      expect(response.status).to eq(401)
      expect(response).to render_template("statics/unauthorized")
    end
  end
end
