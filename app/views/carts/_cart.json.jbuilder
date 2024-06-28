# frozen_string_literal: true

json.extract! cart, :id, :created_at, :updated_at
json.url cart_path(cart, format: :json)
