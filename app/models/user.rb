class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email,
    presence: true,
    uniqueness: true

  validates_length_of :password,
    minimum: 6,
    if: :password

  validates :password,
    presence: true,
    on: :create

  has_many :user_access_tokens,
    inverse_of: :user,
    dependent: :destroy

  def self.with_email!(email)
    where(email: email).first!
  end

  def current_access_token
    user_access_tokens.last
  end
end
