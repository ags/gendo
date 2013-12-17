class RemoveSlugFromApps < ActiveRecord::Migration
  def change
    remove_column :apps, :slug
  end
end
