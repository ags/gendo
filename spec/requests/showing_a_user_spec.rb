require "spec_helper"

describe "showing a user" do
  let(:user) { User.make!(:with_access_token) }
  let(:url) { api_v1_user_url(id: user.id) }

  include_examples "a request requring authorization"

  context "when authorized" do
    let(:authorization) { bearer_auth(user.current_access_token) }
    let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }

    it "responds 200 OK with user details" do
      get url, nil, headers

      expect_response_status(200)
      expect_response_body({user: {
        id: user.id,
        email: user.email,
        name: user.name,
      }}.strict!)
    end
  end
end
