FactoryBot.define do
  factory :reel do
    association :user
    association :line
    sequence(:name) { |n| "Reel #{n}" }
    brand { "SHIMANO" }
    reel_type { 0 }  # enumで定義されている値を想定
    gear_type { 0 }  # enumで定義されている値を想定
    price { 25000 }
    purchase_date { Date.current }
    notes { "Factory generated reel" }
  end
end
