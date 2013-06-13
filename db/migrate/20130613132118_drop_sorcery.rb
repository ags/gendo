class DropSorcery < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.rename :crypted_password, :password_digest
      t.remove :salt
    end
  end

  def down
    change_table :users do |t|
      t.rename :password_digest, :crypted_password
      t.string :salt
    end
  end
end
