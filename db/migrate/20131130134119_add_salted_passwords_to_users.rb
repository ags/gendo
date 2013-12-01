class AddSaltedPasswordsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :password_digest

      t.string :salt
    end
  end
end
