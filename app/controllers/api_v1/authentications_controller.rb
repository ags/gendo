module ApiV1
  class AuthenticationsController < ApiController
    def create
      username, password = params.values_at(:username, :password)

      authentication = Authenticator.new(username, password).authenticate

      if authentication.valid?
        respond_with(@authentication = authentication)
      else
        raise Unauthorized.new(authentication.message)
      end
    end

    private

    def new_session_params
      params.permit(:email, :password)
    end
  end
end
