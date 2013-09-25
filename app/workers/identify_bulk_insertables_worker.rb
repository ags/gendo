class IdentifyBulkInsertablesWorker
  include Sidekiq::Worker

  def self.in_request(request)
    perform_async(request.id)
  end

  def perform(request_id)
    request = Request.find(request_id)

    queries = IdentifiesBulkInsertables.identify(request.sql_events)

    queries.each do |table_name, events_by_columns|
      events_by_columns.each do |column_names, events|
        request.create_bulk_insertable!(table_name, column_names, events)
      end
    end
  end
end
