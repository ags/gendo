module ApiV1
  module Authentication
    def current_app
      App.with_access_token!(bearer_token)
    rescue AuthorizationError, ActiveRecord::RecordNotFound => e
      raise ::ApiV1::Unauthorized, e.message
    end

    def authorized_user
      User.with_access_token!(bearer_token)
    rescue AuthorizationError => e
      raise ::ApiV1::Unauthorized, e.message
    end

    private

    def bearer_token
      if authorization_header.blank?
        raise AuthorizationError, "Authorization header missing or empty."
      elsif authorization_header.match(/\ABearer (.*)\z/)
        $1
      else
        raise AuthorizationError, "Authorization header contains no bearer token."
      end
    end

    def authorization_header
      request.headers["Authorization"]
    end

    Error = Class.new(StandardError)
    AuthorizationError = Class.new(Error)
  end
end
