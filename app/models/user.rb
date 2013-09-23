class User < ActiveRecord::Base
  has_many :apps,
    dependent: :destroy

  validates :email,
    presence: true,
    format: {with: Formats::EMAIL}
end
