class Transaction < ActiveRecord::Base
  belongs_to :app

  has_many :sql_events

  has_many :view_events

  validates :controller,
    presence: true

  validates :action,
    presence: true

  validates :app,
    presence: true

  def self.recent(n=100)
    order('created_at DESC').limit(n)
  end
end
