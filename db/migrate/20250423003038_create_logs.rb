class CreateLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :logs do |t|
      t.date :fishing_date, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :area, null: false
      t.string :fishing_guide_boat, null: false
      t.string :menu, null: false
      t.text :notes, null: false
      t.text :other

      t.timestamps
    end
  end
end
