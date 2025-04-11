class Rod < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :max_weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 700 }
  validates :min_weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 300 }
  validates :length, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  validates :marker, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 1000 }

  enum :fishing_type, {
    fishing_type_none: 0,                   # 指定なし
    jigging_offshore: 1,                    # ジギング系 - オフショア
    light_jigging_slj: 2,                   # ジギング系 - ライトジギング (SLJ)
    deep_jigging: 3,                        # ジギング系 - ディープジギング
    shore_jigging: 4,                       # ジギング系 - ショアジギング
    worm_fishing: 5,                        # ソフトルアー系 - ワームフィッシング
    no_sinker: 6,                           # ソフトルアー系 - ノーシンカー
    texas_rig: 7,                           # ソフトルアー系 - テキサスリグ
    down_shot_rig: 8,                       # ソフトルアー系 - ダウンショットリグ
    carolina_rig: 9,                        # ソフトルアー系 - キャロライナリグ
    split_shot_rig: 10,                     # ソフトルアー系 - スプリットショットリグ
    jig_head_rig: 11,                       # ソフトルアー系 - ジグヘッドリグ
    pencil_bait: 12,                        # トップウォーター系 - ペンシルベイト
    popper: 13,                             # トップウォーター系 - ポッパー
    frog: 14,                               # トップウォーター系 - フロッグ
    spisher: 15,                            # トップウォーター系 - スイッシャー
    crankbait: 16,                          # ハードルアー系 - クランクベイト
    minnow_floating: 17,                    # ハードルアー系 - ミノー (フローティング)
    minnow_sinking: 18,                     # ハードルアー系 - ミノー (シンキング)
    shad: 19,                               # ハードルアー系 - シャッド
    vibration: 20,                          # ハードルアー系 - バイブレーション
    spinnerbait: 21,                        # ハードルアー系 - スピナーベイト
    chatterbait: 22,                        # ハードルアー系 - チャターベイト
    swim_bait: 23,                          # ハードルアー系 - スイムベイト
    sinking_pencil: 24,                     # シーバス系 - シンキングペンシル
    sea_bass_vibration: 25,                 # シーバス系 - バイブレーション
    sea_bass_minnow: 26,                    # シーバス系 - ミノー
    sea_bass_worm: 27,                      # シーバス系 - ワーム
    sea_bass_big_bait: 28,                  # シーバス系 - ビッグベイト
    eging_aoiri: 29,                        # エギング系 - アオリイカ
    light_eging: 30,                        # エギング系 - ライトエギング（ヤリイカ・ヒイカ）
    ikametal: 31,                           # エギング系 - イカメタル
    omorig: 32,                             # エギング系 - オモリグ
    mebaru_fishing: 33,                     # その他ターゲット別 - メバリング
    ajing: 34,                              # その他ターゲット別 - アジング
    rockfish: 35,                           # その他ターゲット別 - ロックフィッシュ（アイナメ・ソイ・カサゴ）
    chining: 36,                            # その他ターゲット別 - チニング（クロダイ）
    bass_fishing: 37,                       # その他ターゲット別 - バスフィッシング（ラージ・スモール）
    trout_fishing: 38,                      # その他ターゲット別 - トラウト（エリア・ネイティブ）
    catfish_fishing: 39,                    # その他ターゲット別 - ナマズゲーム
    gar_fishing: 40,                        # その他ターゲット別 - 雷魚（ライギョ）フィッシング
    trolling: 41,                           # 海外・ビッグゲーム系 - トローリング
    gt_fishing: 42,                         # 海外・ビッグゲーム系 - GTフィッシング
    tuna_casting: 43                        # 海外・ビッグゲーム系 - マグロキャスティング
  }

  enum :power, { power_none: 0, hevy: 1, medium_hevy: 2, medium: 3, medium_light: 4, light: 5 }
  enum :reel_type, { reel_type_none: 0, bait: 1, spining: 2, other: 3 }

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "created_at", "fishing_type", "id", "length", "max_weight", "min_weight", "name", "notes", "power", "purchase_date", "reel_type", "updated_at" ]
  end
end
