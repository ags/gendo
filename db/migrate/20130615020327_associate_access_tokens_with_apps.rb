class AssociateAccessTokensWithApps < ActiveRecord::Migration
  def change
    rename_table :user_access_tokens, :app_access_tokens
    change_table :app_access_tokens do |t|
      t.remove_references :user
      t.references :app, null: false
    end
  end
end
