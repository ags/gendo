class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.references :user, null: false, index: true
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
  end
end
