FactoryBot.define do
  factory :profile do
    association :user
    last_name { "山田" }
    first_name { "太郎" }
    residence { 13 }  # 東京都を想定
    fishing_areas { [ 13 ] }  # 東京都を想定
    interest_fishings { [ 0 ] }  # enumで定義されている値を想定
  end
end
