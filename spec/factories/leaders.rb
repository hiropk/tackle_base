FactoryBot.define do
  factory :leader do
    association :user
    sequence(:name) { |n| "Leader #{n}" }
    brand { "SUNLINE" }
    leader_rating { 12 }  # 12lb
    length { 50 }  # 5.0m
    material { 0 }  # enumで定義されている値を想定
    price { 800 }
    purchase_date { Date.current }
    notes { "Factory generated leader" }
  end
end
