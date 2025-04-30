class Log < ApplicationRecord
  belongs_to :user
  has_many :tackle_selections, dependent: :destroy
  has_many :tackles, through: :tackle_selections

  validates :fishing_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :area, presence: true
  validates :fishing_guide_boat, presence: true
  validates :notes, presence: true, length: { maximum: 10000 }

  scope :on_fishing_date, ->(date) { where(fishing_date: date) }

  RECORD_TEXT = <<~TEXT
    当日は、強い西風の影響で西側エリアは厳しいとのことで、鹿島マリーナから出て多古鼻沖へ。
    到着してからひと流し目はポロポロと！この調子で行くといいんじゃない？と思ってたら修行の時間。
    波が落ち着いてからはポツリポツリまだマシになっていき、ジジー！っと鳴る初心者さんのリール！80upの真鯛。
    なかなか当たりがなく厳しい1日でしたが楽しかった。
  TEXT

  # 釣行日程の年を追加
  ransacker :fishing_year do
    Arel.sql("EXTRACT(YEAR FROM fishing_date)")
  end

  # 釣行日程の月を追加
  ransacker :fishing_month do
    Arel.sql("EXTRACT(MONTH FROM fishing_date)")
  end

  # 釣行日程の日を追加
  ransacker :fishing_day do
    Arel.sql("EXTRACT(DAY FROM fishing_date)")
  end

  def self.ransackable_associations(auth_object = nil)
    [ "tackle_selections", "tackles", "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "area", "created_at", "end_time", "fishing_year", "fishing_month", "fishing_day", "fishing_guide_boat", "id", "menu", "notes", "other", "start_time", "updated_at" ]
  end
end
