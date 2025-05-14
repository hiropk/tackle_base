FactoryBot.define do
  factory :line do
    association :user
    sequence(:name) { |n| "Line #{n}" }
    brand { "VARIVAS" }
    pe_rating { 0.8 }
    length { 150 }  # 150m
    strand_count { "four" }
    marker { true }
    price { 3000 }
    purchase_date { Date.current }
    notes { "Factory generated line" }
  end
end
