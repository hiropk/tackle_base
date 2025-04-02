class CreateRods < ActiveRecord::Migration[8.0]
  def change
    create_table :rods do |t|
      t.string :name, null: false, default: "指定なし"
      t.string :brand, null: false, default: "指定なし"
      t.float :length, null: false, default: 0.0
      t.integer :fishing_type, null: false, default: 0
      t.integer :power, null: false, default: 0
      t.integer :reel_type, null: false, default: 0
      t.integer :min_weight, null: false, default: 0
      t.integer :max_weight, null: false, default: 0
      t.date :purchase_date, null: false, default: -> { 'CURRENT_DATE' }
      t.text :notes

      t.timestamps
    end
  end
end
