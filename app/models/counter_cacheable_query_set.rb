class CounterCacheableQuerySet < ActiveRecord::Base
  belongs_to :request

  has_one :source,
    through: :request

  has_one :app,
    through: :source

  validates :request,
    presence: true

  validates :culprit_association_name,
    presence: true

  has_many :counter_cacheable_query_set_sql_events,
    inverse_of: :counter_cacheable_query_set

  has_many :sql_events,
    through: :counter_cacheable_query_set_sql_events

  def self.exists_for_requests?(requests)
    !!exists?(request_id: requests)
  end
end
