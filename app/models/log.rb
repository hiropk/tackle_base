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

  scope :on_fishing_date, ->(date, user) { where(fishing_date: date, user: user) }

  RECORD_TEXT = <<~TEXT
    朝4時半に鹿島マリーナを出港し、隠岐の島周辺海域を目指しました。
    天候は曇り、風は穏やかで、ジギングにはちょうど良いコンディション。
    ポイントまではおよそ90分。朝のうちに潮が動き始め、魚の活性もまずまず。

    1流し目から青物の反応があり、開始早々にヒット。
    最初に上がってきたのは70cmクラスのハマチで、潮に乗ってよく引きました。
    その後、80cm台のブリ、ヒラマサも顔を見せ、朝の時合いをしっかりとモノに。

    ジグは150〜180gのセミロングタイプを使用。カラーはブルピン、グローヘッドへの反応が目立ちました。
    ボトムからの巻き上げ直後、10〜15m付近でのバイトが多く、タナの意識が釣果に直結する一日。

    中盤は根の荒いエリアに移動し、アコウやマハタなどの根魚も追加。
    特にアコウは40cm超えが3本入り、食味も期待できる嬉しい釣果となりました。

    午後にかけては潮が緩みアタリも減少。
    ラスト1時間は大きな釣果追加はなかったものの、十分な満足感を得て納竿。

    【本日の釣果】

    ブリ×2（最大82cm）

    ヒラマサ×1

    ハマチ×4

    アコウ×3（最大43cm）

    マハタ×1

    帰港は15時過ぎ。整理・片付けを終え、夕方には鹿島マリーナを後にしました。
    釣り・移動・食事すべてを含めて、充実した日帰り遠征でした。
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
