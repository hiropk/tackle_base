FactoryBot.define do
  factory :profile do
    association :user
    last_name { "山田" }
    first_name { "太郎" }
    residence { 13 }  # 東京都を想定
    fishing_areas { [ 13 ] }  # 東京都を想定
    interest_fishings { [ 1 ] }  # jigging_offshoreを想定
  end

  # メール送信機能のテスト用のファクトリー
  factory :mail_test_profile, class: Profile do
    association :user
    last_name { "山田" }
    first_name { "太郎" }
    residence { 31 }  # 島根県を想定
    fishing_areas { [ 31 ] }  # 島根県を想定
    interest_fishings { [ 0, 2 ] }  # 指定なし、light_jigging_sljを想定
  end
end
