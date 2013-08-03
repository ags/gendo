class Request < ActiveRecord::Base
  belongs_to :source

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

  validates :source,
    presence: true

  def create_n_plus_one_query!(table_name, sql_events)
    n_plus_one_queries.create!(
      culprit_table_name: table_name,
      sql_events: sql_events,
    )
  end
end
