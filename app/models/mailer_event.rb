class MailerEvent < ActiveRecord::Base
  belongs_to :request

  has_one :app,
    through: :request

  validates :request,
    presence: true
end
