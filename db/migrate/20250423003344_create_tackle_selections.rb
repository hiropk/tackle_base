class CreateTackleSelections < ActiveRecord::Migration[8.0]
  def change
    create_table :tackle_selections do |t|
      t.references :log, null: false, foreign_key: true
      t.references :tackle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
