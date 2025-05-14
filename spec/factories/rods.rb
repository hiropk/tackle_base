FactoryBot.define do
  factory :rod do
    association :user
    sequence(:name) { |n| "Rod #{n}" }
    brand { "Major Craft" }
    length { 7.6 }  # 7.6フィート
    fishing_type { "sea_bass_minnow" }
    power { "medium" }
    reel_type { "spining" }
    min_weight { 3 }  # PE0.3を想定
    max_weight { 10 }  # PE1.0を想定
    price { 30000 }
    purchase_date { Date.current }
    notes { "Factory generated rod" }
  end
end
