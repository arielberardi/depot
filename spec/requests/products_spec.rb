# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products' do
  let(:product) { create(:product) }

  describe 'GET /index' do
    before { get products_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /new' do
    before { get new_product_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    before { post products_path, params: { product: attributes_for(:product) } }

    it { expect(response).to have_http_status(:redirect) }

    it 'create a new product' do
      expect do
        post products_path, params: { product: attributes_for(:product) }
      end.to change(Product, :count).by(1)
    end
  end

  describe 'GET /edit' do
    before { get edit_product_path(product) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'PUT /update' do
    let(:updated_product) do
      {
        title: product.title,
        price: 100.0,
        description: product.image_url,
        image_url: product.image_url
      }
    end

    before do
      product
      put product_path(id: product), params: { product: updated_product }
    end

    it { expect(response).to have_http_status(:redirect) }
  end

  describe 'DELETE /destroy' do
    before { delete product_path(id: product) }

    it { expect(response).to have_http_status(:redirect) }
  end
end
