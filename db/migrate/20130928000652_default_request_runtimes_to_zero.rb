class DefaultRequestRuntimesToZero < ActiveRecord::Migration
  def change
    change_column_default :requests, :db_runtime, 0
    change_column_default :requests, :view_runtime, 0
    change_column_default :requests, :duration, 0
  end
end
