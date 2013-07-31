class CreateNPlusOneQuerySqlEvents < ActiveRecord::Migration
  def change
    create_table :n_plus_one_query_sql_events do |t|
      t.references :n_plus_one_query, null: false, index: true

      t.references :sql_event, null: false

      t.timestamps
    end
  end
end
