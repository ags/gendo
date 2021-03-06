class User < ActiveRecord::Base
  has_many :apps,
    dependent: :destroy

  validates :email,
    format: {with: Formats::EMAIL}

  def self.from_param!(param)
    where(id: param).first!
  end
end
