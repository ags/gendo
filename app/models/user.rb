class User < ActiveRecord::Base
  include SecurePasswordWithoutValidation

  has_many :apps,
    dependent: :destroy

  validates :email,
    format: {with: Formats::EMAIL}

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
end
