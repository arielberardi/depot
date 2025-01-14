# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :users

  scope '(:locale)' do
    resources :products
    resources :line_items, only: %i[create]
    resources :carts, only: %i[show destroy]
    resources :orders
    root 'store#index', as: 'store_index'
  end
end
