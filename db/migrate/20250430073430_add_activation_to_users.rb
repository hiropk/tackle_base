class AddActivationToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :activation_token, :string
    add_column :users, :activated, :boolean
    add_column :users, :activated_at, :datetime
  end
end
