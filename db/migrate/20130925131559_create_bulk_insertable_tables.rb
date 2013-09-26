class CreateBulkInsertableTables < ActiveRecord::Migration
  def change
    create_table :bulk_insertables do |t|
      t.references :request,
        null: false

      t.string :culprit_table_name,
        null: false

      t.string :column_names,
        array: true,
        null: false

      t.timestamps
    end

    create_table :bulk_insertable_sql_events do |t|
      t.references :bulk_insertable,
        null: false

      t.references :sql_event,
        null: false

      t.timestamps
    end
  end
end
