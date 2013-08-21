class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  has_many :apps,
    dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: true,
    format: {with: Formats::EMAIL, allow_blank: true}

  validates_length_of :password,
    minimum: PasswordPolicy::MINIMUM_LENGTH,
    if: :password

  validates :password,
    presence: true,
    on: :create

  def self.with_email(email)
    where(email: email).first
  end

  def self.email_available?(email)
    !exists?(email: email)
  end
end
