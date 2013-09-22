class AddRequestCountToSources < ActiveRecord::Migration
  def up
    change_table :sources do |t|
      t.integer :requests_count, null: false, default: 0
    end

    Source.reset_column_information
    Source.find_each do |source|
      Source.update_counters(source.id, requests_count: source.requests.count)
    end
  end

  def down
    remove_column :sources, :requests_count
  end
end
