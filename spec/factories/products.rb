# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Commerce.unique.product_name }
    price { Faker::Commerce.price(range: 0.01..1000) }
    image_url { 'test-image.jpg' }
    description { Faker::Lorem.paragraph }
  end
end
