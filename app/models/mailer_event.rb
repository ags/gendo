class MailerEvent < ActiveRecord::Base
  belongs_to :request

  has_one :source,
    through: :request

  has_one :app,
    through: :source

  validates :request,
    presence: true
end
