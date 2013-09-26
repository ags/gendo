class BulkInsertable < ActiveRecord::Base
  belongs_to :request

  has_one :source,
    through: :request

  has_one :app,
    through: :source

  validates :request,
    presence: true

  validates :culprit_table_name,
    presence: true

  validates :column_names,
    presence: true

  has_many :bulk_insertable_sql_events,
    inverse_of: :bulk_insertable

  has_many :sql_events,
    through: :bulk_insertable_sql_events

  def self.exists_for_requests?(requests)
    exists?(request_id: requests)
  end
end
