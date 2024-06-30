# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:address) }

    it { is_expected.to have_many(:line_items) }
  end

  describe '#add_line_items_from_cart' do
    let!(:cart) { create(:cart) }
    let(:order) { create(:order) }

    before do
      create_list(:line_item, 3, cart:)
      order.add_line_items_from_cart(cart)
    end

    it { expect(order.line_items.count).to eq(3) }
    it { expect(cart.line_items.count).to eq(0) }
  end
end
