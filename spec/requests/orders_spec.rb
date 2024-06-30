# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/orders' do
  let(:valid_attributes) { attributes_for(:order) }
  let(:invalid_attributes) { {} }

  let(:product) { create(:product) }

  before { post line_items_path, params: { product_id: product.id } }

  describe 'GET /index' do
    before { get orders_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    let(:order) { create(:order) }

    before { get order_path(order) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /new' do
    before { get new_order_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /edit' do
    let(:order) { create(:order) }

    before { get edit_order_path(order) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Order' do
        expect do
          post orders_url, params: { order: valid_attributes }
        end.to change(Order, :count).by(1)
      end

      it 'redirects to the created order' do
        post orders_url, params: { order: valid_attributes }
        expect(response).to redirect_to(store_index_url)
      end

      it 'queues a charge order job' do
        expect { post orders_url, params: { order: valid_attributes } }.to enqueue_job(ChargeOrderJob)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Order' do
        expect do
          post orders_url, params: { order: invalid_attributes }
        end.not_to change(Order, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post orders_url, params: { order: invalid_attributes }
        expect(response).not_to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /update' do
    let(:order) { create(:order) }

    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: Faker::Name.name,
          address: order.address,
          email: order.email,
          pay_type: order.pay_type
        }
      end

      before { patch order_url(order), params: { order: new_attributes } }

      it { expect(response).to redirect_to(order_url(order)) }
    end

    context 'with invalid parameters' do
      before { patch order_url(order), params: { order: invalid_attributes } }

      it { expect(response).not_to have_http_status(:success) }
    end
  end

  describe 'DELETE /destroy' do
    let!(:order) { create(:order) }

    it 'redirects to index page' do
      delete order_url(order)
      expect(response).to redirect_to(orders_url)
    end

    it 'destroy the order' do
      expect do
        delete order_url(order)
      end.to change(Order, :count).by(-1)
    end
  end
end
