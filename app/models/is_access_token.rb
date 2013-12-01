require 'securerandom'

module IsAccessToken
  extend ActiveSupport::Concern

  module ClassMethods
    attr_writer :token_generator

    def generate(subject)
      new(subject_attribute => subject, token: generate_token)
    end

    private

    def generate_token
      begin
        token = token_generator.call
      end while exists?(token: token); token
    end

    def token_generator
      @token_generator || ->{ SecureRandom.urlsafe_base64(32) }
    end

    # Name of the parent association, e.g. :user or :app.
    def subject_attribute
      reflect_on_all_associations.select(&:belongs_to?).first.name
    end
  end
end
