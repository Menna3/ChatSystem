FactoryBot.define do
  factory :application do
    token { Faker::Lorem.word }
    app_name { Faker::Lorem.word }
    chats_count { Faker::Number.number(10) }
    created_by { Faker::Number.number(10) }
  end
end