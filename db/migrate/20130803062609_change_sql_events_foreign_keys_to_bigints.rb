class ChangeSqlEventsForeignKeysToBigints < ActiveRecord::Migration
  def up
		change_column :n_plus_one_query_sql_events, :sql_event_id, :integer, limit: 8
  end

  def down
		change_column :n_plus_one_query_sql_events, :sql_event_id, :integer, limit: 4
  end
end
