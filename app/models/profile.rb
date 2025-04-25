class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :first_name, presence: true, length: { maximum: 20 }
  validate :fishing_areas_cannot_be_empty
  validate :interest_fishings_cannot_be_empty

  INTEREST_FISHING_TYPES = {
    0 => "fishing_type_none",
    1 => "jigging_offshore",
    2 => "light_jigging_slj",
    3 => "deep_jigging",
    4 => "shore_jigging",
    5 => "worm_fishing",
    6 => "no_sinker",
    7 => "texas_rig",
    8 => "down_shot_rig",
    9 => "carolina_rig",
    10 => "split_shot_rig",
    11 => "jig_head_rig",
    12 => "pencil_bait",
    13 => "popper",
    14 => "frog",
    15 => "spisher",
    16 => "crankbait",
    17 => "minnow_floating",
    18 => "minnow_sinking",
    19 => "shad",
    20 => "vibration",
    21 => "spinnerbait",
    22 => "chatterbait",
    23 => "swim_bait",
    24 => "sinking_pencil",
    25 => "sea_bass_vibration",
    26 => "sea_bass_minnow",
    27 => "sea_bass_worm",
    28 => "sea_bass_big_bait",
    29 => "eging_aoiri",
    30 => "light_eging",
    31 => "ikametal",
    32 => "omorig",
    33 => "mebaru_fishing",
    34 => "ajing",
    35 => "rockfish",
    36 => "chining",
    37 => "bass_fishing",
    38 => "trout_fishing",
    39 => "catfish_fishing",
    40 => "gar_fishing",
    41 => "trolling",
    42 => "gt_fishing",
    43 => "tuna_casting"
  }.freeze

  FISHING_AREAS = {
    0 => "hokkaido",
    1 => "aomori",
    2 => "iwate",
    3 => "miyagi",
    4 => "akita",
    5 => "yamagata",
    6 => "fukushima",
    7 => "ibaraki",
    8 => "tochigi",
    9 => "gunma",
    10 => "saitama",
    11 => "chiba",
    12 => "tokyo",
    13 => "kanagawa",
    14 => "niigata",
    15 => "toyama",
    16 => "ishikawa",
    17 => "fukui",
    18 => "yamanashi",
    19 => "nagano",
    20 => "gifu",
    21 => "shizuoka",
    22 => "aichi",
    23 => "mie",
    24 => "shiga",
    25 => "kyoto",
    26 => "osaka",
    27 => "hyogo",
    28 => "nara",
    29 => "wakayama",
    30 => "tottori",
    31 => "shimane",
    32 => "okayama",
    33 => "hiroshima",
    34 => "yamaguchi",
    35 => "tokushima",
    36 => "kagawa",
    37 => "ehime",
    38 => "kochi",
    39 => "fukuoka",
    40 => "saga",
    41 => "nagasaki",
    42 => "kumamoto",
    43 => "oita",
    44 => "miyazaki",
    45 => "kagoshima",
    46 => "okinawa"
  }.freeze


  enum :residence, {
    hokkaido: 0,
    aomori: 1,
    iwate: 2,
    miyagi: 3,
    akita: 4,
    yamagata: 5,
    fukushima: 6,
    ibaraki: 7,
    tochigi: 8,
    gunma: 9,
    saitama: 10,
    chiba: 11,
    tokyo: 12,
    kanagawa: 13,
    niigata: 14,
    toyama: 15,
    ishikawa: 16,
    fukui: 17,
    yamanashi: 18,
    nagano: 19,
    gifu: 20,
    shizuoka: 21,
    aichi: 22,
    mie: 23,
    shiga: 24,
    kyoto: 25,
    osaka: 26,
    hyogo: 27,
    nara: 28,
    wakayama: 29,
    tottori: 30,
    shimane: 31,
    okayama: 32,
    hiroshima: 33,
    yamaguchi: 34,
    tokushima: 35,
    kagawa: 36,
    ehime: 37,
    kochi: 38,
    fukuoka: 39,
    saga: 40,
    nagasaki: 41,
    kumamoto: 42,
    oita: 43,
    miyazaki: 44,
    kagoshima: 45,
    okinawa: 46
  }

  def fishing_areas_cannot_be_empty
    if fishing_areas.blank? || fishing_areas.reject(&:blank?).empty?
      errors.add(:fishing_areas, "を選択してください")
    end
  end

  def interest_fishings_cannot_be_empty
    if interest_fishings.blank? || interest_fishings.reject(&:blank?).empty?
      errors.add(:interest_fishings, "を選択してください")
    end
  end
end
