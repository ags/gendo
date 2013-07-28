class Transaction < ActiveRecord::Base
  belongs_to :source

  has_many :sql_events

  has_many :view_events

  has_many :mailer_events

  has_many :n_plus_one_queries,
    dependent: :destroy

  validates :source,
    presence: true
end
