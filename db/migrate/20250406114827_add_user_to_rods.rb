class AddUserToRods < ActiveRecord::Migration[8.0]
  def change
    add_reference :rods, :user, null: false, foreign_key: true
  end
end
