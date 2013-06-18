class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.references :app, null: false, index: true
      t.string :controller, null: false
      t.string :action, null: false
      t.string :method_name, null: false
      t.string :format_type, null: false

      t.timestamps
    end
    change_table :transactions do |t|
      t.remove_references :app
      t.remove :controller
      t.remove :action
      t.remove :method
      t.remove :format

      t.references :source, null: false, index: true
    end
  end
end
