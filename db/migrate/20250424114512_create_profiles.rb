class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.integer :residence, null: false
      t.integer :fishing_area, array: true, null: false, default: []
      t.integer :interest_fishing, array: true, null: false, default: []

      t.timestamps
    end
  end
end
