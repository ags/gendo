require "spec_helper"

describe Oauth::GithubController do
  let(:github_oauth_client) { instance_double("GithubOauthClient") }

  describe "GET #authorize" do
    it "redirects to the GitHub OAuth endpoint" do
      allow(GithubOauthClient).to \
        receive(:new).
        and_return(github_oauth_client)

      allow(github_oauth_client).to \
        receive(:authorize_url).
        with("user:email", "repo").
        and_return("http://github.com/login/etc")

      get :authorize

      expect(response).to redirect_to("http://github.com/login/etc")
    end
  end

  describe "GET #callback" do
    let(:signup_form) { double(:signup_form).as_null_object }

    before do
      allow(GithubOauthClient).to \
        receive(:new).
        and_return(github_oauth_client)

      allow(github_oauth_client).to \
        receive(:access_token).
        with("code-123").
        and_return("access-456")

      allow(Form::GithubSignIn).to \
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
