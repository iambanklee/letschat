# frozen_string_literal: true

FactoryBot.define do
  factory :chat_room do
    sequence :name do |n|
      "ChatRoom#{n}"
    end
  end
end
