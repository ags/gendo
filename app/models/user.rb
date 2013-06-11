class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email,
    presence: true,
    uniqueness: true

  validates_length_of :password,
    minimum: 6,
    message: 'must be at least 6 characters long',
    if: :password

  validates :password,
    presence: true,
    on: :create
end
