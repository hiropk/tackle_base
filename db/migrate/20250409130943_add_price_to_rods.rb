class AddPriceToRods < ActiveRecord::Migration[8.0]
  def change
    add_column :rods, :price, :integer, default: 0
  end
end
