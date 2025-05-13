FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "Password123" }
    activated { true }
    activated_at { Time.current }

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
