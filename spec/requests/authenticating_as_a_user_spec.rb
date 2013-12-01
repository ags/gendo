require 'spec_helper'

describe "authenticating as a user" do
  let(:url) { api_v1_authentication_url }
  let(:user) { User.make!(:with_access_token, password: "hunter2") }

  context "with correct email and password" do
    it "responds 200 OK with user ID and current access token" do
      post url, {email: user.email, password: "hunter2"}

      expect_response_status(200)
      expect_response_body({
        user_id: user.id,
        access_token: user.current_access_token.token,
      })
    end
  end

  context "with correct email, incorrect password" do
    it "responds 401 Unauthorized" do
      post url, {email: user.email, password: "nope"}

      expect_response_status(401)
      expect_response_body(message: "Incorrect email or password")
    end
  end

  context "with incorrect email, correct password" do
    it "responds 401 Unauthorized" do
      post url, {email: "nope", password: "hunter2"}

      expect_response_status(401)
      expect_response_body(message: "Incorrect email or password")
    end
  end
end
