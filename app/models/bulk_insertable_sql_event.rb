class BulkInsertableSqlEvent < ActiveRecord::Base
  belongs_to :bulk_insertable

  belongs_to :sql_event

  validates :bulk_insertable,
    presence: true

  validates :sql_event,
    presence: true
end
