# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts' do
  describe 'GET /show' do
    let(:cart) { create(:cart) }

    before { get cart_path(cart) }

    it { expect(response).to be_successful }
  end

  describe 'DELETE /destroy' do
    let(:product) { create(:product) }
    let(:cart) { LineItem.last.cart }

    before { post line_items_path, params: { product_id: product.id } }

    it 'redirects to root page' do
      delete cart_path(cart)
      expect(response).to redirect_to(store_index_url)
    end

    it { expect { delete cart_path(cart) }.to change(Cart, :count).by(-1) }

    context 'when is not part of current session' do
      before { create(:line_item) }

      it { expect { delete cart_path(cart) }.not_to change(Cart, :count) }
    end
  end
end
