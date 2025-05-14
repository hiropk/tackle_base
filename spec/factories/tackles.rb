FactoryBot.define do
  factory :tackle do
    association :user
    association :rod
    association :reel
    association :leader
    sequence(:name) { |n| "Tackle Set #{n}" }
    knot { 0 }
    notes { "Factory generated tackle" }
  end
end
