FactoryBot.define do
  factory :profile do
    association :user
    first_name { "テスト" }
    last_name { "ユーザー" }
    residence { :shimane }
    fishing_areas { [ 31 ] }
    interest_fishings { [ 0 ] }
  end
end
