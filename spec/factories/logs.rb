FactoryBot.define do
  factory :log do
    user
    fishing_date { Date.current }
    area { "Tokyo Bay" }
    fishing_guide_boat { false }
    menu { "seabass" }
    notes { "Test log" }
    other { "Other notes" }
  end
end
