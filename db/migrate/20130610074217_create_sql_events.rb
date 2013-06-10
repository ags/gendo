class CreateSqlEvents < ActiveRecord::Migration
  def change
    create_table :sql_events do |t|
      t.references :transaction

      t.string :sql, limit: 1024
      t.datetime :started_at
      t.datetime :ended_at
      t.float :duration

      t.timestamps
    end
  end
end
