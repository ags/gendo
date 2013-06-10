class Transaction < ActiveRecord::Base
  validates :controller,
    presence: true

  validates :action,
    presence: true

  has_many :sql_events

  def self.recent(n=100)
    order('created_at DESC').limit(n)
  end
end
