FactoryBot.define do
  factory :reel do
    association :user
    association :line
    sequence(:name) { |n| "Reel #{n}" }
    brand { "SHIMANO" }
    reel_type { "spining" }
    gear_type { "normal_gear" }
    price { 25000 }
    purchase_date { Date.current }
    notes { "Factory generated reel" }
  end
end
