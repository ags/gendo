shared_examples_for "an action requiring sign in" do
  context "when logged in" do
    before do
      user = User.make!
      controller.authenticator.sign_in(user)
      action!
    end

    it "is accessible" do
      expect(response.status).to eq(200)
    end
  end

  context "when not logged in" do
    before do
      controller.authenticator.sign_out
      action!
    end

    it "requires login" do
      expect(response.status).to eq(401)
    end
  end
end
