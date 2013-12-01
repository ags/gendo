class AppAccessToken < ActiveRecord::Base
  include IsAccessToken

  belongs_to :app

  validates :app,
    presence: true

  validates :token,
    presence: true
end
