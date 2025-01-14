# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
