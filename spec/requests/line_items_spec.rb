# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/line_items' do
  describe 'POST /create' do
    let!(:product) { create(:product) }

    it 'creates a new LineItem' do
      expect do
        post line_items_path, params: { product_id: product.id }
      end.to change(LineItem, :count).by(1)
    end

    context 'when product is already in the line items' do
      before { post line_items_path, params: { product_id: product.id } }

      it 'does not create a new line item' do
        expect do
          post line_items_path, params: { product_id: product.id }
        end.not_to change(LineItem, :count)
      end

      it 'updates the quantity of line item' do
        expect do
          post line_items_path, params: { product_id: product.id }
        end.to change { LineItem.last.quantity }.by(1)
      end
    end

    it 'redirects to the created line_item' do
      post line_items_path, params: { product_id: product.id }
      expect(response).to redirect_to(cart_url(LineItem.last.cart))
    end

    context 'with invalid parameters' do
      it 'does not create a new LineItem' do
        expect do
          post line_items_path, params: { product_id: '' }
        end.not_to change(LineItem, :count)
      end

      it 'renders a response with 404 status' do
        post line_items_path, params: { product_id: '' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
