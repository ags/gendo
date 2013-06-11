require 'spec_helper'

describe UserAccessToken do
  describe ".generate" do
    let(:user) { User.new }
    subject(:user_access_token) { UserAccessToken.generate(user) }

    before do
      SecureRandom.stub(:urlsafe_base64).
        and_return("first_token", "second_token")
    end

    it "instantiates a new UserAccessToken" do
      expect(user_access_token.user).to eq(user)
      expect(user_access_token.token).to eq('first_token')
    end

    it "does not persist the token" do
      expect(user_access_token.persisted?).to be_false
    end

    context "if a UserAccessToken already exists with the generated token" do
      before do
        UserAccessToken.make!(token: 'first_token')
      end

      it "generates a different token" do
        expect(user_access_token.token).to eq('second_token')
      end
    end
  end
end
