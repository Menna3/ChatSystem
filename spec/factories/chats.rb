FactoryBot.define do
  factory :chat do
    chat_number { Faker::Number.number(10) }
    messages_count { Faker::Number.number(10) }
    done false
    application_id nil
  end
end