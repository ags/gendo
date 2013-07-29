class Transaction < ActiveRecord::Base
  belongs_to :source

  has_many :sql_events

  has_many :view_events

  has_many :mailer_events

  has_many :n_plus_one_queries,
    inverse_of: :transaction,
    dependent: :destroy

  validates :source,
    presence: true

  def create_n_plus_one_query!(table_name, sql_events)
    n_plus_one_queries.create!(
      culprit_table_name: table_name,
      sql_events: sql_events,
    )
  end
end
