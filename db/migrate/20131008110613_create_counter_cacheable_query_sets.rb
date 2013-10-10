class CreateCounterCacheableQuerySets < ActiveRecord::Migration
  def change
    create_table :counter_cacheable_query_sets do |t|
      t.references :request,
        null: false

      t.string :culprit_association_name,
        null: false

      t.integer :sql_events_count,
        null: false,
        default: 0

      t.timestamps
    end

    create_table :counter_cacheable_query_set_sql_events do |t|
      t.references :counter_cacheable_query_set,
        null: false

      t.references :sql_event,
        null: false

      t.timestamps
    end
  end
end
