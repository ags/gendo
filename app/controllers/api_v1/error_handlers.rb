module ApiV1
  module ErrorHandlers
    extend ActiveSupport::Concern

    included do
      # Catch-all handler, must be declared first
      rescue_from StandardError,
        with: :respond_with_error

      rescue_from Unauthorized,
        with: :respond_with_unauthorized

      rescue_from ActiveRecord::RecordInvalid,
        with: :respond_with_validation_failed

      rescue_from ActiveRecord::RecordNotFound, NotFound,
        with: :respond_with_not_found
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

    def respond_with_validation_failed(error)
      render status: :unprocessable_entity,
        json: {
          message: "Validation failed.",
          errors: extract_validation_errors(error)
        }
    end

    def respond_with_not_found(error)
      render status: :not_found,
        json: {message: "Resource not found."}
    end

    def extract_validation_errors(error)
      error.record.errors.messages.map do |field, messages|
        messages.map do |message|
          {
            resource: error.record.class.name,
            field: field,
            message: message
          }
        end
      end.flatten
    end

    def verbose_errors?
      !Rails.env.production?
    end
  end
end
