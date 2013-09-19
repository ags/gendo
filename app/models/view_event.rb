class ViewEvent < ActiveRecord::Base
  belongs_to :request

  validates :request,
    presence: true

  validates :identifier,
    presence: true
end
