class UserAccessToken < ActiveRecord::Base
  include IsAccessToken

  belongs_to :user

  validates :user,
    presence: true

  validates :token,
    presence: true

  def self.current
    order(:created_at).last
  end
end
