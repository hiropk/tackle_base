class RemoveDefaultFromRods < ActiveRecord::Migration[8.0]
  def change
    change_column_default :rods, :name, from: "指定なし", to: nil
    change_column_default :rods, :brand, from: "指定なし", to: nil
  end
end
