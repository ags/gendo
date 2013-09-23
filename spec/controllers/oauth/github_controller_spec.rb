require "spec_helper"

describe Oauth::GithubController do
  describe "GET #authorize" do
    it "redirects to the GitHub OAuth endpoint" do
      get :authorize

      expect(response).to redirect_to(
        "https://github.com/login/oauth/authorize?"\
        "response_type=code&"\
        "client_id=#{ENV["GITHUB_CLIENT_ID"]}&"\
        "scope=user%3Aemail%2Crepo"
      )
    end
  end

  describe "GET #callback" do
    let(:github_oauth_client) { double(:github_oauth_client) }
    let(:signup_form) { double(:signup_form).as_null_object }

    before do
      allow(GithubOauthClient).to \
        receive(:new).
        and_return(github_oauth_client)

      allow(github_oauth_client).to \
        receive(:access_token).
        with("code-123").
        and_return("access-456")

      allow(Forms::GithubSignIn).to \
        receive(:new).
        with(controller.authenticator, github_access_token: "access-456").
        and_return(signup_form)
    end

    it "signs a User in from Github" do
      expect(signup_form).to \
        receive(:save!)

      get :callback, code: "code-123"
    end

    it "redirects to root" do
      get :callback, code: "code-123"

      expect(response).to redirect_to(root_url)
    end
  end
end
