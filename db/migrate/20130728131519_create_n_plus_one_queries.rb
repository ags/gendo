class CreateNPlusOneQueries < ActiveRecord::Migration
  def change
    create_table :n_plus_one_queries do |t|
      t.references :transaction, index: true

      t.string :culprit_table_name, null: false

      t.timestamps
    end
  end
end
