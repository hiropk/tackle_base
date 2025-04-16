class CreateTackles < ActiveRecord::Migration[8.0]
  def change
    create_table :tackles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.references :rod, null: false, foreign_key: true
      t.references :reel, null: false, foreign_key: true
      t.integer :knot, null: false
      t.references :leader, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
