class AddNameToSqlEvents < ActiveRecord::Migration
  def change
    change_table :sql_events do |t|
      t.string :name
    end
  end
end
