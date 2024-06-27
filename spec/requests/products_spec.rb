# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/products' do
  let!(:product) { create(:product) }

  describe 'GET /index' do
    before { get products_url }

    it { expect(response).to be_successful }
  end

  describe 'GET /new' do
    before { get new_product_url }

    it { expect(response).to be_successful }
  end

  describe 'POST /create' do
    before { post products_url, params: { product: attributes_for(:product) } }

    it { expect(response).to have_http_status(:redirect) }

    it 'create a new product' do
      expect do
        post products_url, params: { product: attributes_for(:product) }
      end.to change(Product, :count).by(1)
    end
  end

  describe 'GET /edit' do
    before { get edit_product_url(product) }

    it { expect(response).to be_successful }
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

    before { put product_url(id: product), params: { product: updated_product } }

    it { expect(response).to have_http_status(:redirect) }
  end

  describe 'DELETE /destroy' do
    before { delete product_url(id: product) }

    it { expect(response).to have_http_status(:redirect) }
  end
end
