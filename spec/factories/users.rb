FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "P@ssword1234" }
    password_digest { BCrypt::Password.create("password123") }
    is_admin { false }
    activated { true }
    activated_at { Time.current }

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
