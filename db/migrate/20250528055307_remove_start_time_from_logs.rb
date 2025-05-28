class RemoveStartTimeFromLogs < ActiveRecord::Migration[8.0]
  def change
    remove_column :logs, :start_time, :time
  end
end
