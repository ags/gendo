class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  has_many :apps,
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
end
