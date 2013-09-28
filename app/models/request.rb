class Request < ActiveRecord::Base
  belongs_to :source,
    counter_cache: true

  has_one :app,
    through: :source

  has_many :sql_events,
    dependent: :destroy

  has_many :view_events,
    dependent: :destroy

  has_many :mailer_events,
    dependent: :destroy

  has_many :n_plus_one_queries,
    inverse_of: :request,
    dependent: :destroy

  has_many :bulk_insertables,
    inverse_of: :request,
    dependent: :destroy

  validates :source,
    presence: true

  before_validation do
    self.duration     ||= 0
    self.db_runtime   ||= 0
    self.view_runtime ||= 0
  end

  def create_n_plus_one_query!(table_name, sql_events)
    n_plus_one_queries.create!(
      culprit_table_name: table_name,
      sql_events: sql_events,
    )
  end

  def create_bulk_insertable!(table_name, column_names, sql_events)
    bulk_insertables.create!(
      culprit_table_name: table_name,
      column_names:       column_names,
      sql_events:         sql_events,
    )
  end
end
