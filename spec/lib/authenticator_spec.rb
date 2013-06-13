require 'authenticator'

describe Authenticator do
  let(:session) { {} }
  let(:authenticator) { Authenticator.new(session) }

  describe "#sign_in" do
    it "sets the session user_id to the given User ID" do
      user = stub(id: 123)
      authenticator.sign_in(user)
      expect(session[:user_id]).to eq(123)
    end
  end

  describe "#logged_in?" do
    context "when logged in" do
      let(:session) { {user_id: 123} }
      before do
        authenticator.user_finder = ->(id) { stub(:user) }
      end

      it "is true" do
        expect(authenticator.logged_in?).to be_true
      end
    end

    context "when logged out" do
      it "is false" do
        expect(authenticator.logged_in?).to be_false
      end
    end
  end

  describe "#current_user" do
    context "when logged in" do
      let(:session) { {user_id: 123} }
      let(:user) { stub(:user) }

      before do
        authenticator.user_finder = ->(id) { user }
      end

      it "is the authenticated User instance" do
        expect(authenticator.current_user).to be(user)
      end
    end

    context "when logged out" do
      it "is an AnonUser instance" do
        expect(authenticator.current_user).to be_a(Authenticator::AnonUser)
      end
    end
  end
end
