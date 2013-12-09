require 'spec_helper'

describe "listing apps" do
  let(:user) { User.make!(:with_access_token) }
  let(:url) { api_v1_apps_url }

  include_examples "a request requring authorization"

  context "when authorized" do
    let(:authorization) { bearer_auth(user.current_access_token) }
    let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }

    it "returns the apps associated with the authenticated user" do
      app = App.make!(user: user)

      get url, nil, headers

      expect_response_status(200)
      expect_response_body({
        apps: [
          {
            id: app.id,
            name: app.name,
            slug: app.slug,
          },
        ]
      })
    end
  end
end
