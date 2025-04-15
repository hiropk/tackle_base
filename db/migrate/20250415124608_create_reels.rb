class CreateReels < ActiveRecord::Migration[8.0]
  def change
    create_table :reels do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :brand, null: false
      t.integer :reel_type, null: false
      t.integer :gear_type, null: false
      t.references :line, null: false, foreign_key: true
      t.integer :price, null: false, default: 0
      t.date :purchase_date, null: false, default: -> { 'CURRENT_DATE' }
      t.text :notes

      t.timestamps
    end
  end
end
