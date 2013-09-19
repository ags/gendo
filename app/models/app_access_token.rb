require 'securerandom'

class AppAccessToken < ActiveRecord::Base
  belongs_to :app

  validates :app,
    presence: true

  validates :token,
    presence: true

  class << self
    def generate(app)
      new(app: app, token: generate_token)
    end

    private

    def generate_token
      begin
        token = SecureRandom.urlsafe_base64(32)
      end while exists?(token: token); token
    end
  end
end
