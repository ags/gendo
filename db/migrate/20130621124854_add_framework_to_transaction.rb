class AddFrameworkToTransaction < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.string :framework
    end
  end
end
