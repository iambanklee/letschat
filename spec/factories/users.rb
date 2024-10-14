# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "test@local.com" }
    password { "password1" }
    display_name { "Test User" }
  end
end
