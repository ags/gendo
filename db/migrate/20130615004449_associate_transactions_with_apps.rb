class AssociateTransactionsWithApps < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.remove_references :user
      t.references :app, null: false
    end
  end
end
