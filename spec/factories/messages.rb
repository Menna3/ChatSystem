FactoryBot.define do
  factory :message do
    message_number { Faker::Number.number(10) }
    messages_body { Faker::Lorem.word }
    done false
    chat_id nil
  end
end