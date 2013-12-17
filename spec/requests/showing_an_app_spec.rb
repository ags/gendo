require 'spec_helper'

describe "showing an app" do
  let(:_app) { App.make!(user: user) }
  let(:user) { User.make!(:with_access_token) }

  let(:authorization) { bearer_auth(user.current_access_token) }
  let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }
  let(:url) { api_v1_app_url(id: _app.id) }

  include_examples "a request requring authorization"

  context "when authorized as the app owner" do
    let(:authorization) { bearer_auth(user.current_access_token) }
    let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }

    it "responds with 200 OK with the app details" do
      get url, nil, headers

      expect_response_status(200)
      expect_response_body({app: {
        id: _app.id,
        slug: _app.slug,
        name: _app.name,
      }}.strict!)
    end
  end

  context "when authorized, but not the app owner" do
    let(:_app) { App.make! }

    it "responds with 404 Not Found" do
      get url, nil, headers

      expect_response_status(404)
      expect_response_body({
        message: "Resource not found."
      }.strict!)
    end
  end
end
