module ApiV1
  module ErrorHandlers
    extend ActiveSupport::Concern

    included do
      # Catch-all handler, must be declared first
      rescue_from StandardError,
        with: :respond_with_error

      rescue_from Unauthorized,
        with: :respond_with_unauthorized
    end

    private

    def respond_with_error(error)
      render status: 500, json: if verbose_errors?
        {
          type: error.class.name,
          message: error.message,
          backtrace: error.backtrace
        }
      else
        {
          type: error.class.name
        }
      end
    end

    def respond_with_unauthorized(error)
      render status: :unauthorized,
        json: {message: error.message || "Unauthorized"}
    end

    def verbose_errors?
      !Rails.env.production?
    end
  end
end
