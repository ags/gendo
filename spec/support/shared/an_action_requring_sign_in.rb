shared_examples_for "an action requiring sign in" do
  context "when logged in" do
    before do
      expect(controller.authenticator).to \
        receive(:logged_in?).
        and_return(true)

      action!
    end

    it "is accessible" do
      expect(response.status).to eq(200)
    end
  end

  context "when not logged in" do
    before do
      stub_authenicator

      expect(controller.authenticator).to \
        receive(:logged_in?).
        and_return(false)

      action!
    end

    it "requires login" do
      expect(response.status).to eq(401)
    end
  end

  def stub_authenicator
    authenticator = instance_double("Authenticator")

    allow(controller).to \
      receive(:authenticator).
      and_return(authenticator)
  end
end
