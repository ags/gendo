require "github_oauth_client"

describe GithubOauthClient do
  let(:client_id) { "foo" }
  let(:client_secret) { "bar" }
  subject(:client) { GithubOauthClient.new(client_id, client_secret) }

  describe "#authorize_url" do
    it "returns the GitHub OAuth endpoint for the given scopes" do
      expect(client.authorize_url("repo")).to eq(
        "https://github.com/login/oauth/authorize?"\
        "response_type=code&"\
        "client_id=foo&"\
        "scope=repo"
      )
    end
  end
end
