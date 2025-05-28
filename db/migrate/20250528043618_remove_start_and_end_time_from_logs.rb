class RemoveStartAndEndTimeFromLogs < ActiveRecord::Migration[8.0]
  def change
    remove_column :logs, :start_time, :datetime
    remove_column :logs, :end_time, :datetime
  end
end
