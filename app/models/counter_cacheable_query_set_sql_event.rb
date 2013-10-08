class CounterCacheableQuerySetSqlEvent < ActiveRecord::Base
  belongs_to :counter_cacheable_query_set,
    counter_cache: :sql_events_count

  belongs_to :sql_event

  validates :counter_cacheable_query_set,
    presence: true

  validates :sql_event,
    presence: true
end
