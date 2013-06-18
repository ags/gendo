class CreateViewEvents < ActiveRecord::Migration
  def change
    create_table :view_events do |t|
      t.references :transaction, index: true

      t.string :identifier, null: false
      t.datetime :started_at
      t.datetime :ended_at
      t.float :duration

      t.timestamps
    end
  end
end
