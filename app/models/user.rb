class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  MINIMUM_PASSWORD_LENGTH = 6

  has_many :apps,
    dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: true,
    format: {with: Formats::EMAIL, allow_blank: true}

  validates_length_of :password,
    minimum: MINIMUM_PASSWORD_LENGTH,
    if: :password

  validates :password,
    presence: true,
    on: :create

  def self.with_email!(email)
    where(email: email).first!
  end
end
