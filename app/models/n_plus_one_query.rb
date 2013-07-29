class NPlusOneQuery < ActiveRecord::Base
  belongs_to :transaction

  validates :transaction,
    presence: true

  validates :culprit_table_name,
    presence: true

  has_many :n_plus_one_query_sql_events,
    inverse_of: :n_plus_one_query

  has_many :sql_events,
    through: :n_plus_one_query_sql_events
end
