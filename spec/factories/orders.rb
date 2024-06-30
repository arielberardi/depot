# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    pay_type { ['Check', 'Credit Card', 'Purchase order'].sample }
  end
end
