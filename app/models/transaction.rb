class Transaction < ActiveRecord::Base
  validates :controller,
    presence: true

  validates :action,
    presence: true

  has_many :sql_events

  has_many :view_events

  def self.recent(n=100)
    order('created_at DESC').limit(n)
  end

  # TODO this is presenter level
  def events
    (sql_events + view_events).sort_by(&:started_at)
  end
end
