require 'spec_helper'

describe AppAccessToken do
  describe ".generate" do
    let(:app) { App.new }
    subject(:app_access_token) { AppAccessToken.generate(app) }

    before do
      SecureRandom.stub(:urlsafe_base64).
        and_return("first_token", "second_token")
    end

    it "instantiates a new AppAccessToken" do
      expect(app_access_token.app).to eq(app)
      expect(app_access_token.token).to eq('first_token')
    end

    it "does not persist the token" do
      expect(app_access_token.persisted?).to be_false
    end

    context "if a AppAccessToken already exists with the generated token" do
      before do
        AppAccessToken.make!(token: 'first_token')
      end

      it "generates a different token" do
        expect(app_access_token.token).to eq('second_token')
      end
    end
  end
end
