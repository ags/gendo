class NPlusOneQuery < ActiveRecord::Base
  belongs_to :request

  has_one :source,
    through: :request

  has_one :app,
    through: :source

  validates :request,
    presence: true

  validates :culprit_table_name,
    presence: true

  has_many :n_plus_one_query_sql_events,
    inverse_of: :n_plus_one_query

  has_many :sql_events,
    through: :n_plus_one_query_sql_events

  def self.exists_for_requests?(requests)
    exists?(request_id: requests)
  end

  def duration
    sql_events.sum(:duration)
  end
end
