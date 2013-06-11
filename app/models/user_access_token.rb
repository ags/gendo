require 'securerandom'

class UserAccessToken < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :user_access_tokens

  class << self
    def generate(user)
      new(user: user, token: generate_token)
    end

    private

    def generate_token
      begin
        token = SecureRandom.urlsafe_base64(32)
      end while exists?(token: token); token
    end
  end

end
