# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    product
    cart
  end
end
