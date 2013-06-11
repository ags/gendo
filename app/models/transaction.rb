class Transaction < ActiveRecord::Base
  belongs_to :user

  has_many :sql_events

  has_many :view_events

  validates :controller,
    presence: true

  validates :action,
    presence: true

  validates :user,
    presence: true

  def self.recent(n=100)
    order('created_at DESC').limit(n)
  end

  # TODO this is presenter level
  def events
    (sql_events + view_events).sort_by(&:started_at)
  end
end
