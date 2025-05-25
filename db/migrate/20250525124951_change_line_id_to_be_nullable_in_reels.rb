class ChangeLineIdToBeNullableInReels < ActiveRecord::Migration[8.0]
  def change
    change_column_null :reels, :line_id, true
  end
end
