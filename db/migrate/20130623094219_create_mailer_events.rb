class CreateMailerEvents < ActiveRecord::Migration
  def change
    create_table :mailer_events do |t|
      t.references :transaction, index: true

      t.string :mailer, null: false
      t.string :message_id

      t.datetime :started_at
      t.datetime :ended_at
      t.float :duration

      t.timestamps
    end
  end
end
