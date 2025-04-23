class Log < ApplicationRecord
  belongs_to :user
  has_many :tackle_selections, dependent: :destroy
  has_many :tackles, through: :tackle_selections

  # 釣行日程の年を追加
  ransacker :fishing_year do
    Arel.sql("EXTRACT(YEAR FROM fishing_date)")
  end

  # 釣行日程の月を追加
  ransacker :fishing_month do
    Arel.sql("EXTRACT(MONTH FROM fishing_date)")
  end

  def self.ransackable_associations(auth_object = nil)
    [ "tackle_selections", "tackles", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "area", "created_at", "end_time", "fishing_year", "fishing_month", "fishing_guide_boat", "id", "menu", "notes", "other", "start_time", "updated_at" ]
  end
end
