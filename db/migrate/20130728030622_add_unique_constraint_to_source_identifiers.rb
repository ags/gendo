class AddUniqueConstraintToSourceIdentifiers < ActiveRecord::Migration
  def up
    add_index :sources,
      [:app_id, :controller, :action, :method_name, :format_type],
      name: :index_sources_on_identifying_attributes,
      unique: true
  end

  def down
    remove_index :sources, name: :index_sources_on_identifying_attributes
  end
end
