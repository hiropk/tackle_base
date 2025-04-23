class AddUserToLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :logs, :user, null: false, foreign_key: true
  end
end
