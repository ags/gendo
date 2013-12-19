class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation
  include HasAccessTokens

  has_many :apps,
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
end
