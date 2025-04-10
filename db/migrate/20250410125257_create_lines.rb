class CreateLines < ActiveRecord::Migration[8.0]
  def change
    create_table :lines do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: "指定なし"
      t.string :brand, null: false, default: "指定なし"
      t.decimal :pe_rating, null: false
      t.integer :length, null: false
      t.integer :strand_count, null: false
      t.boolean :marker, null: false, default: true
      t.integer :price, default: 0
      t.date :purchase_date, null: false, default: -> { 'CURRENT_DATE' }
      t.text :notes

      t.timestamps
    end
  end
end
