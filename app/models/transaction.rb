class Transaction < ActiveRecord::Base
  belongs_to :source

  has_many :sql_events

  has_many :view_events

  validates :source,
    presence: true
end
