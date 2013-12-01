require 'securerandom'

class AppAccessToken < ActiveRecord::Base
  belongs_to :app

  validates :app,
    presence: true

  validates :token,
    presence: true

  class << self
    attr_writer :token_generator

    def generate(app)
      new(app: app, token: generate_token)
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
  end
end
