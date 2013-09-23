class ConvertUsersToOauth < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :password_digest

      t.integer :github_user_id
      t.string :github_access_token
      t.string :name
    end
  end

  def down
    change_table :users do |t|
      t.remove :github_user_id
      t.remove :github_access_token
      t.remove :name

      t.string :password_digest
    end
  end
end
