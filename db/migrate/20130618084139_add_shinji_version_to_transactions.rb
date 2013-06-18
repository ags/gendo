class AddShinjiVersionToTransactions < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.string :shinji_version
    end
  end
end
