class Transaction < ActiveRecord::Base
  belongs_to :source

  has_one :app,
    through: :source

  has_many :sql_events,
    dependent: :destroy

  has_many :view_events,
    dependent: :destroy

  has_many :mailer_events,
    dependent: :destroy

  validates :source,
    presence: true
end
