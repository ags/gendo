class ChangeIdsToBigints < ActiveRecord::Migration
	def change_id_limit(table, limit)
		change_column table, :id, :integer, limit: limit
	end

  def up
		change_id_limit :transactions, 8
		change_id_limit :mailer_events, 8
		change_id_limit :sql_events, 8
		change_id_limit :view_events, 8
  end

  def down
		change_id_limit :transactions, 4
		change_id_limit :mailer_events, 4
		change_id_limit :sql_events, 4
		change_id_limit :view_events, 4
  end
end
