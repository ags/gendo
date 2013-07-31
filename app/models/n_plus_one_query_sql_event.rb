class NPlusOneQuerySqlEvent < ActiveRecord::Base
  belongs_to :n_plus_one_query

  belongs_to :sql_event

  validates :n_plus_one_query,
    presence: true

  validates :sql_event,
    presence: true
end
