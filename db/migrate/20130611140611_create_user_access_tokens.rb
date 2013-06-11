class CreateUserAccessTokens < ActiveRecord::Migration
  def change
    create_table :user_access_tokens do |t|
      t.references :user, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end
