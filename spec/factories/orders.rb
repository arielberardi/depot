# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    email { Faker::Internet.email }
    pay_type { Order.pay_types.keys.sample }
  end
end
