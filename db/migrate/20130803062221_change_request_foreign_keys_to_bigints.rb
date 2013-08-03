class ChangeRequestForeignKeysToBigints < ActiveRecord::Migration
  def up
    change_request_id_limit :mailer_events, 8
    change_request_id_limit :n_plus_one_queries, 8
    change_request_id_limit :sql_events, 8
    change_request_id_limit :view_events, 8
  end

  def down
    change_request_id_limit :mailer_events, 4
    change_request_id_limit :n_plus_one_queries, 4
    change_request_id_limit :sql_events, 4
    change_request_id_limit :view_events, 4
  end

	def change_request_id_limit(table, limit)
		change_column table, :request_id, :integer, limit: limit
	end
end
