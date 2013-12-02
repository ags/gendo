class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  has_many :apps,
    dependent: :destroy

  has_many :user_access_tokens,
    dependent: :destroy

  validates :email,
    format: {with: Formats::EMAIL},
    uniqueness: true

  validates_length_of :password,
    minimum: PasswordPolicy::MINIMUM_LENGTH,
    if: :password

  validates :password,
    presence: true,
    on: :create,
    if: ->{ github_user_id.nil? }

  def self.from_param!(param)
    where(id: param).first!
  end

  def self.with_email(email)
    where(email: email).first
  end

  def self.with_access_token!(access_token)
    # TODO this should check for current token
    joins(:user_access_tokens).
      where(user_access_tokens: {token: access_token}).
      first!
  end

  def current_access_token
    user_access_tokens.current
  end
end
