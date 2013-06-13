class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  has_many :user_access_tokens,
    dependent: :destroy

  has_many :transactions,
    dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: true

  validates_length_of :password,
    minimum: 6,
    if: :password

  validates :password,
    presence: true,
    on: :create

  def self.with_email!(email)
    where(email: email).first!
  end

  def current_access_token
    user_access_tokens.last
  end
end
