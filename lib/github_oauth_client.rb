require 'oauth2'

class GithubOauthClient
  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
  end

  def authorize_url(*scopes)
    client.auth_code.authorize_url(scope: scopes.join(','))
  end

  def access_token(code)
    client.auth_code.get_token(code).token
  end

  private

  def client
    @_client ||= OAuth2::Client.new(
      @client_id,
      @client_secret,
      authorize_url: 'https://github.com/login/oauth/authorize',
      token_url:     'https://github.com/login/oauth/access_token',
    )
  end
end
