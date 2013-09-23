module Oauth
  class GithubController < ApplicationController
    def authorize
      redirect_to github_client.authorize_url("user:email", "repo")
    end

    def callback
      github_access_token = github_client.access_token(params[:code])

      form = Forms::GithubSignIn.new(
        authenticator,
        github_access_token: github_access_token
      )
      form.save!

      redirect_to root_url
    end

    private

    def github_client
      @_github_client ||= GithubOauthClient.new(
        ENV.fetch("GITHUB_CLIENT_ID"),
        ENV.fetch("GITHUB_CLIENT_SECRET")
      )
    end
  end
end
