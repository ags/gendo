class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :controller, null: false
      t.string :action, null: false
      t.string :path
      t.string :format
      t.string :method
      t.integer :status
      t.datetime :started_at
      t.datetime :ended_at
      t.float :db_runtime
      t.float :view_runtime
      t.float :duration

      t.timestamps
    end
  end
end
