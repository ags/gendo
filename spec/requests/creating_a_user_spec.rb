require 'spec_helper'

describe "creating a user" do
  let(:url) { api_v1_users_url }

  context "with valid email and password" do
    it "responds 201 Created with user details and current access token" do
      post url, user: {email: "shinji@nerv.org", password: "hunter2"}

      expect_response_status(201)
      expect_response_body({
        user: {
          id: :user_id,
          email: "shinji@nerv.org",
        },
        authentication: {
          user_id: :user_id,
          access_token: :access_token,
        }
      })
    end
  end

  context "without a valid email" do
    it "responds with 422 Unprocessable Entity" do
      post url, user: {email: nil, password: "hunter2"}

      expect_validation_failure(
        resource: "User",
        field:    "email",
        message:  "is invalid"
      )
    end
  end

  context "with an email that has already been taken" do
    it "responds with 422 Unprocessable Entity" do
      User.make!(email: "shinji@nerv.org")

      post url, user: {email: "shinji@nerv.org", password: "hunter2"}

      expect_validation_failure(
        resource: "User",
        field:    "email",
        message:  "has already been taken"
      )
    end
  end
end
