class AddUserToTransaction < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.references :user, null: false
    end
  end
end
