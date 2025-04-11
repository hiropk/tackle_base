class RemoveDefaultFromLines < ActiveRecord::Migration[8.0]
  def change
    change_column_default :lines, :name, from: "指定なし", to: nil
    change_column_default :lines, :brand, from: "指定なし", to: nil
  end
end
