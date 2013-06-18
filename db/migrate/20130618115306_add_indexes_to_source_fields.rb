class AddIndexesToSourceFields < ActiveRecord::Migration
  def up
    add_index :sources, :controller
    add_index :sources, :action
    add_index :sources, :method_name
  end

  def down
    remove_index :sources, :controller
    remove_index :sources, :action
    remove_index :sources, :method_name
  end
end
