class MailerEvent < ActiveRecord::Base
  belongs_to :request

  validates :request, presence: true
end
