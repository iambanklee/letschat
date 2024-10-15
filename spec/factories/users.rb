# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test_#{n}@local.com"
    end
    password { "password1" }
    display_name { "Test User" }
  end
end
