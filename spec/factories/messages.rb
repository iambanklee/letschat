FactoryBot.define do
  factory :message do
    user { nil }
    chat_room { nil }
    content { "MyText" }
  end
end
