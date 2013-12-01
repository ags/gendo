require_relative "../../lib/serializable_struct"
require_relative "../../app/models/user_authentication"
require_relative "../../app/models/invalid_authentication"
require_relative "../../app/gendo/authenticator"

describe Authenticator do
  let(:user) { instance_double("User") }
  let(:authenticator) { Authenticator.new("shinji@nerv.com", "hunter2") }

  subject(:authentication) { authenticator.authenticate }

  before do
    authenticator.user_finder = ->{ user }
  end

  context "with a user" do
    before do
      allow(user).to \
        receive(:authenticate).
        with("hunter2").
        and_return(valid_credentials)
    end

    context "with valid credentials" do
      let(:valid_credentials) { true }

      it "returns a UserAuthentication for the user" do
        expect(authentication).to eq(UserAuthentication.new(user))
      end
    end

    context "with invalid credentials" do
      let(:valid_credentials) { false }

      it "returns an InvalidAuthentication" do
        expect_invalid_authentication
      end
    end
  end

  context "without a user" do
    let(:user) { nil }

    it "returns an InvalidAuthentication" do
      expect_invalid_authentication
    end
  end

  def expect_invalid_authentication
    expect(authentication).to \
      eq(InvalidAuthentication.new("Incorrect email or password"))
  end
end
