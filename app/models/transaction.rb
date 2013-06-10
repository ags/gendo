class Transaction < ActiveRecord::Base
  validates :controller,
    presence: true

  validates :action,
    presence: true

  has_many :sql_events
end
